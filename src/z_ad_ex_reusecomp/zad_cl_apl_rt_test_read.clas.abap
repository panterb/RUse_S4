CLASS zad_cl_apl_rt_test_read DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zad_cl_apl_rt_test_read IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TRY.
        DATA(lo_filter) = cl_bali_log_filter=>create( ).
        "lo_filter->set_create_info( user = sy-uname ).

        "Create a filter which selects all logs of the current user from the last hour
        DATA(lv_timestamp_now) = utclong_current( ).
        DATA(lv_timestamp_minus_1_hour) = utclong_add(
          val   = lv_timestamp_now
          hours = '4-' ).

       lo_filter->set_time_interval(
          start_time = lv_timestamp_minus_1_hour
          end_time   = lv_timestamp_now ).

        lo_filter->set_descriptor(
          object    = zad_if_online_shop_constants=>cs_apl-object-online_shop
          subobject = zad_if_online_shop_constants=>cs_apl-subobject-online_shops ).

        DATA(lt_logs) = cl_bali_log_db=>get_instance( )->load_logs_via_filter( filter = lo_filter ).

        LOOP AT lt_logs INTO DATA(lo_log).
"          out->write( |Handle: { lo_log->get_handle( ) }| ).

          DATA(lo_header) = lo_log->get_header( ).
          out->write( |{ lo_header->object } { lo_header->subobject } { lo_header->external_id } { lo_header->log_user }| ).

          DATA(lt_items) = lo_log->get_all_items( ).
          LOOP AT lt_items INTO DATA(ls_item).
            out->write( |{ ls_item-log_item_number } { ls_item-item->get_message_text( ) }| ).

            " Output attributes which are specific for messages and exceptions
            IF ls_item-item->category = if_bali_constants=>c_category_message.
              DATA(lo_messag) = CAST if_bali_message_getter( ls_item-item ).
              out->write( |{ lo_messag->id } { lo_messag->number }| ).
            ELSEIF ls_item-item->category = if_bali_constants=>c_category_exception.
              DATA(lo_exception) = CAST if_bali_exception_getter( ls_item-item ).
              out->write( |{ lo_exception->exception_class } { lo_exception->exception_id_name }| ).
            ENDIF.
          ENDLOOP.
       ENDLOOP.

      CATCH cx_bali_runtime INTO DATA(lx_bali_runtime).
        out->write( lx_bali_runtime->get_text(  ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
