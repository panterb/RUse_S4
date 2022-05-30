CLASS zad_cl_apl_rt_test_create DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zad_cl_apl_rt_test_create IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

      TRY.
        DATA(lo_log) = cl_bali_log=>create( ).

        lo_log->set_header( header = cl_bali_header_setter=>create( object = zad_if_online_shop_constants=>cs_apl-object-online_shop
                                                                    subobject = zad_if_online_shop_constants=>cs_apl-subobject-online_shops
                                                                    external_id = 'zad_cl_apl_rt_test' ) ).

        MESSAGE ID 'ZAD_ONLINE_SHOP' TYPE 'S' NUMBER '030' with '3' INTO DATA(lv_message).
        lo_log->add_item( item = cl_bali_message_setter=>create_from_sy( ) ).


        cl_bali_log_db=>get_instance( )->save_log( log = lo_log ).
        out->write( 'Log is saved succesfully' ).

      CATCH cx_bali_runtime INTO DATA(l_runtime_exception).
       out->write( l_runtime_exception->get_text(  ) ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
