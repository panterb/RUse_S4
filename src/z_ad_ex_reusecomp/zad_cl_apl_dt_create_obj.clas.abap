CLASS zad_cl_apl_dt_create_obj DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZAD_CL_APL_DT_CREATE_OBJ IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_log_object) = cl_bali_object_handler=>get_instance( ).

    TRY.
        lo_log_object->create_object(
          iv_object            = zad_if_online_shop_constants=>cs_apl-object-online_shop
          iv_object_text       = 'Log Object for Online Shop'
          it_subobjects        = VALUE #( (
                                   subobject      = zad_if_online_shop_constants=>cs_apl-subobject-online_shops
                                   subobject_text = 'Log Subobject for Online Shop' ) )
          iv_package           = 'Z_AD_EX_REUSECOMP'
          iv_transport_request = 'FHJK900110' ).

      CATCH cx_bali_objects INTO DATA(lx_exception).
        out->write( lx_exception->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
