CLASS lsc_zzad_r_orderingtp_ext DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

ENDCLASS.

CLASS lsc_zzad_r_orderingtp_ext IMPLEMENTATION.

ENDCLASS.

CLASS lhc_extension_ORDERING DEFINITION INHERITING FROM cl_abap_behavior_handler.
public section.
    CONSTANTS:
      validate_delivery_date   TYPE string VALUE 'VALIDATE_DELIVERY_DATE' ##NO_TEXT.

  PRIVATE SECTION.

      methods zzad_update_deliverydate for modify
       IMPORTING it_keys for action ordering~zzad_update_deliverydate RESULT result.

      methods zzad_check_delivery_date  for validate on save importing it_keys  for  ordering~zzad_check_delivery_date.

       methods zzcalculate_order_id for DETERMINE ON modify importing it_keys for ordering~zzcalculate_order_id.

      METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ordering RESULT result.

ENDCLASS.

CLASS lhc_extension_ORDERING IMPLEMENTATION.

  method  zzad_update_deliverydate.

      LOOP AT it_keys REFERENCE INTO DATA(lr_key).

      MODIFY ENTITIES OF zad_i_orderingtp in LOCAL MODE
        ENTITY Ordering UPDATE SET FIELDS WITH VALUE #(
        ( %tky                            = lr_key->%tky
          %data-Deliverydate              = lr_key->%param-deliverydate )
         )
        MAPPED   DATA(ls_modify_mapped)
        FAILED   DATA(ls_modify_failed)
        REPORTED DATA(ls_modify_reported).


    ENDLOOP.

  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  method zzad_check_delivery_date.

         data:
            online_shops TYPE TABLE FOR UPDATE zad_i_orderingtp,
            online_shop  TYPE STRUCTURE FOR UPDATE zad_i_orderingtp.
            READ ENTITIES OF zad_i_orderingtp IN LOCAL MODE
             ENTITY Ordering
              ALL FIELDS
                WITH CORRESPONDING #( it_keys )
                RESULT DATA(lt_online_shop_result)
            FAILED    DATA(lt_failed)
            REPORTED  DATA(lt_reported).


          LOOP AT lt_online_shop_result INTO DATA(online_shop_read).
            online_shop = CORRESPONDING #( online_shop_read ).
                if online_shop_read-Deliverydate = '00000000'.
                  APPEND VALUE #( %tky        = online_shop_read-%tky
                      %state_area = validate_delivery_date
                      %msg        = NEW zad_cx_ordering( textid      = zad_cx_ordering=>date_invalid )
                      %element-Deliverydate = if_abap_behv=>mk-on
                      ) TO reported-ordering .


                endif.
    ENDLOOP.


 ENDMETHOD.

method zzcalculate_order_id.
Data:
      online_shops TYPE TABLE FOR UPDATE zad_i_orderingtp,
      online_shop  TYPE STRUCTURE FOR UPDATE zad_i_orderingtp.

   SELECT MAX( order_id ) FROM zad_i_orderingtp INTO @DATA(max_order_id).  "#EC CI_NOWHERE.

    READ ENTITIES OF zad_i_orderingtp IN LOCAL MODE
       ENTITY Ordering
        ALL FIELDS
          WITH CORRESPONDING #( it_keys )
          RESULT DATA(lt_online_shop_result)
      FAILED    DATA(lt_failed)
      REPORTED  DATA(lt_reported).


    LOOP AT lt_online_shop_result INTO DATA(online_shop_read).
      max_order_id += 1.
      online_shop               = CORRESPONDING #( online_shop_read ).
      online_shop-order_id      = max_order_id.
      APPEND online_shop TO online_shops.
    ENDLOOP.
    MODIFY ENTITIES OF zad_i_orderingtp IN LOCAL MODE
   ENTITY Ordering UPDATE SET FIELDS WITH online_shops
   MAPPED   DATA(ls_mapped_modify)
   FAILED   DATA(lt_failed_modify)
   REPORTED DATA(lt_reported_modify).

ENDMETHOD.



ENDCLASS.
