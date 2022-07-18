CLASS zad_cl_apj_buslogic_xco_xlsx DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZAD_CL_APJ_BUSLOGIC_XCO_XLSX IMPLEMENTATION.


 METHOD if_apj_dt_exec_object~get_parameters.
    " Parameter Description for Application Jobs Template:
    et_parameter_def = VALUE #(
        ( selname = 'P_DESCR' kind = if_apj_dt_exec_object=>parameter     datatype = 'C' length = 80 param_text = 'Description'   lowercase_ind = abap_true changeable_ind = abap_true )
      ).

    " Parameter Table for Application Jobs Template:
    et_parameter_val = VALUE #(
      ( selname = 'P_DESCR' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = 'Job Template for Online Shop' )
    ).
  ENDMETHOD.

 method if_oo_adt_classrun~main.
    " Business Logic
        types:
               tt_online_shop TYPE STANDARD TABLE OF zad_online_shop WITH DEFAULT KEY.
        data lt_online_shop type tt_online_shop.

        " Get file content
        SELECT zad_i_stream~FileContent  FROM zad_i_stream
        WITH PRIVILEGED ACCESS
        WHERE description = 'OfflineOrdering3'
        INTO @DATA(lv_file_content).
       ENDSELECT.

        DATA(lo_worksheet) = xco_cp_xlsx=>document->for_file_content( lv_file_content
           )->read_access(
           )->get_workbook(
           )->worksheet->at_position( 1 ).

        DATA(lo_cursor) = lo_worksheet->cursor(
           io_column = xco_cp_xlsx=>coordinate->for_alphabetic_value( 'A' )
           io_row    = xco_cp_xlsx=>coordinate->for_numeric_value( 1 )
        ).

        DATA(lo_selection_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(
          )->from_column( lo_cursor->position->column
          )->from_row( lo_cursor->position->row
          )->to_column( lo_cursor->position->column->shift( 2 )
          )->get_pattern( ).

        TYPES:

          BEGIN OF ts_offline_ordering,
            ordereditem         TYPE string,
            deliverydate        TYPE dats,
          END OF ts_offline_ordering,

        tt_offline_ordering TYPE STANDARD TABLE OF ts_offline_ordering WITH DEFAULT KEY.
        DATA lt_offline_ordering TYPE tt_offline_ordering.

        lo_worksheet->select( lo_selection_pattern
          )->row_stream(
          )->operation->write_to( REF #( lt_offline_ordering )
          )->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value
          )->execute( ).

        DATA:
          online_shops TYPE TABLE FOR create zad_i_online_shop,
          online_shop  TYPE STRUCTURE FOR create zad_i_online_shop.

        DATA(today) = cl_abap_context_info=>get_system_date( ).

       SELECT MAX( order_id ) FROM zad_online_shop INTO @DATA(max_order_id).  "#EC CI_NOWHERE.

       LOOP AT lt_offline_ordering INTO DATA(ls_offline_ordering).
         max_order_id += 1.
         online_shop-ordereditem = ls_offline_ordering-ordereditem.
         online_shop-order_id      = max_order_id.
         online_shop-Creationdate = ls_offline_ordering-deliverydate.
         "online_shop-Creationdate  = today.
         online_shop-Deliverydate  = today + 10.
        APPEND online_shop TO online_shops.
       ENDLOOP.

      MODIFY ENTITIES OF zad_i_online_shop
       ENTITY online_shop create SET FIELDS WITH  online_shops
       MAPPED   DATA(ls_mapped_modify)
       FAILED   DATA(lt_failed_modify)
       REPORTED DATA(lt_reported_modify).

       COMMIT ENTITIES RESPONSE OF zad_i_online_shop FAILED DATA(lt_failed) REPORTED DATA(lt_data_reported).
 ENDMETHOD..

  METHOD if_apj_rt_exec_object~execute.

    TRY.
        DATA(lo_log) = cl_bali_log=>create( ).

        lo_log->set_header( header = cl_bali_header_setter=>create( object = zad_if_online_shop_constants=>cs_apl-object-online_shop
                                                                    subobject = zad_if_online_shop_constants=>cs_apl-subobject-online_shops
                                                                    external_id = 'demo' ) ).

        " Business Logic
        types:
               tt_online_shop TYPE STANDARD TABLE OF zad_online_shop WITH DEFAULT KEY.
        data lt_online_shop type tt_online_shop.

        " Get file content
        SELECT zad_i_stream~FileContent  FROM zad_i_stream
        WITH PRIVILEGED ACCESS
        WHERE description = 'OfflineOrdering3'
        INTO @DATA(lv_file_content).
       ENDSELECT.

        DATA(lo_worksheet) = xco_cp_xlsx=>document->for_file_content( lv_file_content
           )->read_access(
           )->get_workbook(
           )->worksheet->at_position( 1 ).

        DATA(lo_cursor) = lo_worksheet->cursor(
           io_column = xco_cp_xlsx=>coordinate->for_alphabetic_value( 'A' )
           io_row    = xco_cp_xlsx=>coordinate->for_numeric_value( 1 )
        ).

        DATA(lo_selection_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(
          )->from_column( lo_cursor->position->column
          )->from_row( lo_cursor->position->row
          )->to_column( lo_cursor->position->column->shift( 2 )
          )->get_pattern( ).

        TYPES:

          BEGIN OF ts_offline_ordering,
            ordereditem         TYPE string,
            deliverydate        TYPE d,
          END OF ts_offline_ordering,

        tt_offline_ordering TYPE STANDARD TABLE OF ts_offline_ordering WITH DEFAULT KEY.
        DATA lt_offline_ordering TYPE tt_offline_ordering.

        lo_worksheet->select( lo_selection_pattern
          )->row_stream(
          )->operation->write_to( REF #( lt_offline_ordering )
          )->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value
          )->execute( ).

        DATA:
          online_shops TYPE TABLE FOR create zad_i_online_shop,
          online_shop  TYPE STRUCTURE FOR create zad_i_online_shop.

        DATA(today) = cl_abap_context_info=>get_system_date( ).

       SELECT MAX( order_id ) FROM zad_online_shop INTO @DATA(max_order_id).  "#EC CI_NOWHERE.

       LOOP AT lt_offline_ordering INTO DATA(ls_offline_ordering).
         max_order_id += 1.
         online_shop-ordereditem = ls_offline_ordering-ordereditem.
         online_shop-order_id      = max_order_id.
         online_shop-Creationdate = ls_offline_ordering-deliverydate.
         "online_shop-Creationdate  = today.
         online_shop-Deliverydate  = today + 10.
        APPEND online_shop TO online_shops.
       ENDLOOP.

      MODIFY ENTITIES OF zad_i_online_shop
       ENTITY online_shop create SET FIELDS WITH  online_shops
       MAPPED   DATA(ls_mapped_modify)
       FAILED   DATA(lt_failed_modify)
       REPORTED DATA(lt_reported_modify).

       COMMIT ENTITIES RESPONSE OF zad_i_online_shop FAILED DATA(lt_failed) REPORTED DATA(lt_data_reported).

        MESSAGE ID 'ZAD_ONLINE_SHOP' TYPE 'S' NUMBER '033' WITH sy-dbcnt  INTO DATA(lv_message).
        lo_log->add_item( item = cl_bali_message_setter=>create_from_sy( ) ).

        cl_bali_log_db=>get_instance( )->save_log( log = lo_log assign_to_current_appl_job = abap_true ).

      CATCH cx_bali_runtime INTO DATA(l_runtime_exception).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
