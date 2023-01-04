CLASS zad_cl_appl_log_compile_excel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      class-DATA: report TYPE zad_xco_report.
      INTERFACES if_oo_adt_classrun .
      INTERFACES if_apj_dt_exec_object .
      INTERFACES if_apj_rt_exec_object .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zad_cl_appl_log_compile_excel IMPLEMENTATION.

METHOD if_apj_dt_exec_object~get_parameters.
    " Parameter Description for Application Jobs Template
    et_parameter_def = VALUE #(
        ( selname = 'P_DESCR' kind = if_apj_dt_exec_object=>parameter     datatype = 'C' length = 80 param_text = 'Description'   lowercase_ind = abap_true changeable_ind = abap_true )
      ).

    " Parameter Table for Application Jobs Template
    et_parameter_val = VALUE #(
      ( selname = 'P_DESCR' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = 'Job Template for Online Shop' )
    ).
  ENDMETHOD.

    METHOD if_apj_rt_exec_object~execute.

    ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

     TRY.

    " Generate the XLSX report.
      DATA(lo_document) = xco_cp_xlsx=>document->empty(
        )->write_access( ).
      DATA(lo_worksheet) = lo_document->get_workbook(
        )->worksheet->at_position( 1 ).

     "Read the application logs
     DATA(lo_filter) = cl_bali_log_filter=>create( ).

     "Create a filter which selects all logs of the current user from the last hour
     DATA(lv_timestamp_now) = utclong_current( ).
     DATA(lv_timestamp_minus_24_hour) = utclong_add(
          val   = lv_timestamp_now
          hours = '24-' ).

       lo_filter->set_time_interval(
          start_time = lv_timestamp_minus_24_hour
          end_time   = lv_timestamp_now ).

        lo_filter->set_descriptor(
          object    = zad_if_online_shop_constants=>cs_apl-object-online_shop
          subobject = zad_if_online_shop_constants=>cs_apl-subobject-online_shops ).

        DATA(lt_logs) = cl_bali_log_db=>get_instance( )->load_logs_via_filter( filter = lo_filter ).

       " Writer the header of the worksheet
        DATA(lo_cursor) = lo_worksheet->cursor(
         io_column = xco_cp_xlsx=>coordinate->for_alphabetic_value( 'A' )
         io_row    = xco_cp_xlsx=>coordinate->for_numeric_value( 1 )
         ).
        lo_cursor->get_cell( )->value->write_from( 'Application log entries' ).
        lo_cursor->move_down( ).

        "Write logs in the excel
        LOOP AT lt_logs INTO DATA(lo_log).

          DATA(lo_header) = lo_log->get_header( ).

          " Prepare the data that shall be written into the XLSX report.
          DATA(lv_date) = CONV d( xco_cp=>sy->date( )->as( xco_cp_time=>format->abap )->value ).
          DATA(lv_time) = CONV t( xco_cp=>sy->time( )->as( xco_cp_time=>format->abap )->value ).
          DATA(lv_user) = lo_header->log_user.
          data(lv_object) = lo_header->object.
          data(lv_subobject) = lo_header->subobject.

         "Write the header information
             "Write the current date
             lo_cursor->move_down( )->get_cell( )->value->write_from( 'Date:' ).
             lo_cursor->move_right( )->get_cell( )->value->write_from( lv_date ).

             " Write the current time
             lo_cursor->move_down( )->move_left( )->get_cell( )->value->write_from( 'Time:' ).
             lo_cursor->move_right( )->get_cell( )->value->write_from( lv_time ).

             " Write the application log entry user
             lo_cursor->move_down( )->move_left( )->get_cell( )->value->write_from( 'User:' ).
             lo_cursor->move_right( )->get_cell( )->value->write_from( lv_user ).

             "Write the object
              lo_cursor->move_down( )->move_left( )->get_cell( )->value->write_from( 'Object:' ).
              lo_cursor->move_right( )->get_cell( )->value->write_from( lv_object ).

              "Write the sub-object
              lo_cursor->move_down( )->move_left( )->get_cell( )->value->write_from( 'Sub-Object:' ).
              lo_cursor->move_right( )->get_cell( )->value->write_from( lv_subobject ).

              lo_cursor->move_down( )->move_down( ).


              DATA(lt_items) = lo_log->get_all_items( ).


             " Write the application log info into the worksheet
             DATA(lo_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(
                 )->from_column( xco_cp_xlsx=>coordinate->for_alphabetic_value( 'A' )
                 )->from_row( lo_cursor->position->row
                 )->get_pattern( ).

             lo_worksheet->select( lo_pattern
              )->row_stream(
              )->operation->write_from( REF #( lt_items )
              )->set_value_transformation( xco_cp_xlsx_write_access=>value_transformation->best_effort
              )->execute( ).

                 LOOP AT lt_items INTO DATA(ls_item).
                          out->write( |{ ls_item-log_item_number } { ls_item-item->get_message_text( ) }| ).
                          "Output attributes which are specific for messages and exceptions
                          IF ls_item-item->category = if_bali_constants=>c_category_message.
                           DATA(lo_messag) = CAST if_bali_message_getter( ls_item-item ).
                           out->write( |{ lo_messag->id } { lo_messag->number }| ).
                          ELSEIF ls_item-item->category = if_bali_constants=>c_category_exception.
                           DATA(lo_exception) = CAST if_bali_exception_getter( ls_item-item ).
                           out->write( |{ lo_exception->exception_class } { lo_exception->exception_id_name }| ).
                          ENDIF.
                 ENDLOOP.
             ENDLOOP.

      DATA(lv_file_content) = lo_document->get_file_content( ).

      zad_cl_appl_log_compile_excel=>report = VALUE #(
        Excel         = lv_file_content
        ExcelMimetype = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        ExcelFilename = 'report.xlsx'
      ).



      "Add excel file to the stream BO
      DATA: lt_stream TYPE TABLE FOR CREATE zad_i_stream.
      data: ls_stream type STRUCTURE FOR CREATE zad_i_stream.

      "Prepare data for adding the excel file
      ls_stream-%cid = 'My%CID_1'.
      ls_stream-FileName = 'Excel_Report.xlsx'.
      ls_stream-Description = 'Excel_Report.xlsx'.
      ls_stream-FileContent =  lv_file_content.
      ls_stream-MimeType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'.
      APPEND ls_stream to lt_stream.

      "Modify EML for the stream BO
      MODIFY ENTITIES OF zad_i_stream entity stream create SET FIELDS WITH lt_stream
      MAPPED   DATA(ls_mapped_modify)
      FAILED   DATA(lt_failed_modify)
      REPORTED DATA(lt_reported_modify).

      COMMIT ENTITIES RESPONSE OF zad_i_stream FAILED DATA(lt_failed) REPORTED DATA(lt_data_reported).

        "Create email instance
        DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).

        "Define sender and recipient
        lo_mail->set_sender( 'alda.dollani@sap.com' ).
        lo_mail->add_recipient( 'alda.dollani@sap.com' ).
        lo_mail->set_subject( 'Notification: Job complete' ).

        "Set mail attributes
        lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
          iv_content      = '<h1>Confirmation</h1><p>The job to process the items uploaded via XLSX is finished successfully.</p>'
          iv_content_type = 'text/html'
        ) ).

        "Add attachment to the email
        lo_mail->add_attachment( cl_bcs_mail_binarypart=>create_instance(
         iv_content      = lv_file_content
         iv_content_type = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
         iv_filename     = 'ApplicationData.xlsx'
        ) ).

        "Send email and get the status
        "lo_mail->send( IMPORTING et_status = DATA(lt_status) ).

       CATCH cx_bcs_mail INTO DATA(lx_mail).
        out->write( EXPORTING data = |Exception: { lx_mail->get_longtext( ) }| ).
       CATCH cx_bali_runtime INTO DATA(lx_bali_runtime).

    endtry.

    ENDMETHOD.

ENDCLASS.
