CLASS lsc_zzad_r_orderingtp_ext DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

ENDCLASS.

CLASS lsc_zzad_r_orderingtp_ext IMPLEMENTATION.

ENDCLASS.

CLASS lhc_extension_ORDERING DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    methods get_instance_features for instance FEATURES
     importing it_keys request  requested_features for zz_ExtNode RESULT result.

      methods zzad_update_deliverydate for modify
       IMPORTING it_keys for action ordering~zzad_update_deliverydate RESULT result.

      methods zzad_check_delivery_date  for validate on save importing it_keys  for  ordering~zzad_check_delivery_date.

       methods zzcalculate_order_id for DETERMINE ON modify importing it_keys for ordering~zzcalculate_order_id.

      METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ordering RESULT result.

ENDCLASS.

CLASS lhc_extension_ORDERING IMPLEMENTATION.

  method get_instance_features.
   READ ENTITIES OF zad_i_orderingtp IN LOCAL MODE
      ENTITY zz_ExtNode
        FIELDS ( FreeTextComment )
        WITH CORRESPONDING #( it_keys )
        RESULT DATA(lt_results)
      FAILED failed.

    result = VALUE #(
        FOR results IN lt_results
        LET enabled = if_abap_behv=>fc-o-enabled  IN
        (
          %tky = results-%tky
          %update = enabled
          %delete = enabled
        )
      ).
  ENDMETHOD.

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
