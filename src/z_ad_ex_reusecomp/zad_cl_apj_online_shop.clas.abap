CLASS zad_cl_apj_online_shop DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zad_cl_apj_online_shop IMPLEMENTATION.


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


  METHOD if_apj_rt_exec_object~execute.

    TRY.
        DATA(lo_log) = cl_bali_log=>create( ).

        lo_log->set_header( header = cl_bali_header_setter=>create( object = zad_if_online_shop_constants=>cs_apl-object-online_shop
                                                                    subobject = zad_if_online_shop_constants=>cs_apl-subobject-online_shops
                                                                    external_id = 'demo' ) ).

        " Business Logic
        DATA lt_online_shop TYPE STANDARD TABLE OF zad_i_online_shop WITH DEFAULT KEY.
        SELECT zad_i_online_shop~order_uuid FROM zad_i_online_shop
        WITH PRIVILEGED ACCESS

        WHERE zad_i_online_shop~deliverydate < @sy-datum "@sy-datlo
        AND zad_i_online_shop~ordereditem = 'Laptop'
        INTO TABLE @lt_online_shop.

        MESSAGE ID 'ZAD_ONLINE_SHOP' TYPE 'S' NUMBER '032' WITH sy-dbcnt  INTO DATA(lv_message).
        lo_log->add_item( item = cl_bali_message_setter=>create_from_sy( ) ).

        cl_bali_log_db=>get_instance( )->save_log( log = lo_log assign_to_current_appl_job = abap_true ).

      CATCH cx_bali_runtime INTO DATA(l_runtime_exception).
*        out->write( l_runtime_exception->get_text(  ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
