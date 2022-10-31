CLASS lsc_zhb_i_online_shop_act DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

class lad_ordering DEFINITION INHERITING FROM cl_abap_behavior_handler.
   public section.
    CONSTANTS:
      val_delivery_date   TYPE string VALUE 'VALIDATE_DELIVERY_DATE' ##NO_TEXT.

   PRIVATE SECTION.

    Methods validate_delivery_date for validate on save importing it_keys  for  online_shop~validate_delivery_date.
ENDCLASS.

CLASS lad_ordering IMPLEMENTATION.
  METHOD validate_delivery_date.
        data:
            online_shops TYPE TABLE FOR UPDATE zad_i_online_shop,
            online_shop  TYPE STRUCTURE FOR UPDATE zad_i_online_shop.
            READ ENTITIES OF zad_i_online_shop IN LOCAL MODE
             ENTITY online_shop
              ALL FIELDS
                WITH CORRESPONDING #( it_keys )
                RESULT DATA(lt_online_shop_result)
            FAILED    DATA(lt_failed)
            REPORTED  DATA(lt_reported).


      try.

      "data: lt_factory_calendar type table of zad_scsfactory.

       cl_scal_api=>factory_calendar_get(
       IMPORTING
       et_factory_calendars = data(lt_factory_calendar)
        ).


         data(lo_mapper) = CL_FHC_CALENDAR_ID_MAPPER=>create_id_mapper(  ).
         data(lv_scal_id) = lo_mapper->mapping_fcal_legacyid_to_id( iv_legacy_id = '01' ).

        data(lo_hcal_run) = cl_fhc_calendar_runtime=>create_holidaycalendar_runtime(
         iv_holidaycalendar_id = lv_scal_id ).

        data(lo_fcal_run) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime(
          iv_factorycalendar_id = lv_scal_id ).

          LOOP AT lt_online_shop_result INTO DATA(online_shop_read).
            online_shop = CORRESPONDING #( online_shop_read ).

              if online_shop_read-Deliverydate NE '00000000'.
                "Check if the delivery date is a holiday
                data(is_holiday) = lo_hcal_run->is_holiday(
                 iv_date =  online_shop_read-Deliverydate
                 ).

               "Check if the delivery date is a holiday
                if is_holiday = abap_true.
                  APPEND VALUE #( %tky        = online_shop_read-%tky
                      %state_area = val_delivery_date
                      %msg        = NEW zad_cx_ordering( textid      = zad_cx_ordering=>date_holiday )
                      %element-Deliverydate = if_abap_behv=>mk-on
                      ) TO reported-online_shop .
                endif.
              else.
                "Check if the delivery date is not empty
                if online_shop_read-Deliverydate = '00000000'.
                  APPEND VALUE #( %tky        = online_shop_read-%tky
                      %state_area = val_delivery_date
                      %msg        = NEW zad_cx_ordering( textid      = zad_cx_ordering=>date_invalid )
                      %element-Deliverydate = if_abap_behv=>mk-on
                      ) TO reported-online_shop .
                endif.
             ENDIF.
           ENDLOOP.

        catch cx_fhc_runtime into data(lx_err).
        CATCH cx_scal into data(lx_scal).
        "exception handling
      endtry.
  ENDMETHOD.
ENDCLASS.

CLASS lsc_zhb_i_online_shop_act IMPLEMENTATION.

  METHOD save_modified.
    DATA : lt_online_shop_ad TYPE STANDARD TABLE OF zad_onshop_ad,
           ls_online_shop_as TYPE                   zad_onshop_ad.
    IF zbp_ad_i_online_shop=>cv_pr_mapped-purchaserequisition IS NOT INITIAL.
      LOOP AT zbp_ad_i_online_shop=>cv_pr_mapped-purchaserequisition ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
        CONVERT KEY OF i_purchaserequisitiontp FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
        <fs_pr_mapped>-purchaserequisition = ls_pr_key-purchaserequisition.
      ENDLOOP.
    ENDIF.


    IF create-online_shop IS NOT INITIAL.
      " Creates internal table with instance data
      lt_online_shop_ad = CORRESPONDING #( create-online_shop ).
      lt_online_shop_ad[ 1 ]-purchasereqn =  ls_pr_key-purchaserequisition .

      insert zad_onshop_ad FROM TABLE @lt_online_shop_ad.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zhb_i_online_online_shop DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR  online_shop RESULT result.

    METHODS create_pr FOR MODIFY
      IMPORTING keys FOR ACTION online_shop~create_pr.

    METHODS calculate_order_id FOR DETERMINE ON MODIFY
      IMPORTING keys FOR online_shop~calculate_order_id.


ENDCLASS.

CLASS lhc_zhb_i_online_online_shop IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create_pr.
**  if a new laptop is ordered, trigger a new purchase requisition
    IF keys IS NOT INITIAL.
      MODIFY ENTITIES OF i_purchaserequisitiontp
 ENTITY purchaserequisition
    CREATE FIELDS ( purchaserequisitiontype )
    WITH VALUE #(  ( %cid                    = 'My%CID_1'
                     purchaserequisitiontype = 'NB' ) )

   CREATE BY \_purchaserequisitionitem
   FIELDS ( plant
            purchaserequisitionitemtext
            accountassignmentcategory
            requestedquantity
            baseunit
            purchaserequisitionprice
            purreqnitemcurrency
            materialgroup
            purchasinggroup
            purchasingorganization
                )
   WITH VALUE #(
                 (    %cid_ref = 'My%CID_1'
                      %target = VALUE #(
                                       (  %cid                            = 'My%ItemCID_1'
                                          plant                           = '1010'
                                          purchaserequisitionitemtext     = 'PAAS API Test 08.07.2022'
                                            accountassignmentcategory     = 'U'
                                          requestedquantity               = '8.00'
                                          baseunit                        = 'EA'
                                          purchaserequisitionprice        = '13.00'
                                          purreqnitemcurrency             = 'EUR'
                                          materialgroup                   = 'A001'
                                          purchasinggroup                 = '001'
                                          purchasingorganization          = '1010'

                                          )
                                       )
                  )
                )
 ENTITY purchaserequisitionitem
CREATE BY \_purchasereqnacctassgmt
    FIELDS ( CostCenter
             GLAccount
             Quantity
             BaseUnit )
    WITH VALUE #( (   %cid_ref = 'My%ItemCID_1'
                      %target  = VALUE #( ( %cid         = 'My%AccntCID_1'
                                            CostCenter   = 'JMW-COST'
                                            GLAccount    = '0000400000' ) ) ) )
CREATE BY \_purchasereqnitemtext
   FIELDS ( plainlongtext )
   WITH VALUE #(  (   %cid_ref = 'My%ItemCID_1'
                      %target  = VALUE #( ( %cid         = 'My%TextCID_1'
                                          textobjecttype = 'B01'
                                          language       = 'E'
                                          plainlongtext  = 'Item text created from PAAS API 08.07.2022'
                                        ) ( %cid         = 'My%TextCID_2'
                                          textobjecttype = 'B02'
                                          language       = 'E'
                                          plainlongtext  = 'Item2 text created from PAAS API 08.07.2022'
                                        ) )
              )   )
          REPORTED DATA(ls_pr_reported)
          MAPPED DATA(ls_pr_mapped)
          FAILED DATA(ls_pr_failed).
      zbp_ad_i_online_shop=>cv_pr_mapped = ls_pr_mapped.

    ENDIF.
  ENDMETHOD.


  METHOD calculate_order_id.
    DATA:
      online_shops TYPE TABLE FOR UPDATE zad_i_online_shop,
      online_shop  TYPE STRUCTURE FOR UPDATE zad_i_online_shop.
*      delete from zhb_online_shop UP TO 15 ROWS.
    SELECT MAX( order_id ) FROM zad_online_shop INTO @DATA(max_order_id).  "#EC CI_NOWHERE.
    READ ENTITIES OF zad_i_online_shop IN LOCAL MODE
       ENTITY online_shop
        ALL FIELDS
          WITH CORRESPONDING #( keys )
          RESULT DATA(lt_online_shop_result)
      FAILED    DATA(lt_failed)
      REPORTED  DATA(lt_reported).
    DATA(today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT lt_online_shop_result INTO DATA(online_shop_read).
      max_order_id += 1.

      online_shop               = CORRESPONDING #( online_shop_read ).
      online_shop-order_id      = max_order_id.
      online_shop-Creationdate  = today.
     " online_shop-Deliverydate  = today + 10.
      APPEND online_shop TO online_shops.
    ENDLOOP.
    MODIFY ENTITIES OF zad_i_online_shop IN LOCAL MODE
   ENTITY online_shop UPDATE SET FIELDS WITH online_shops
   MAPPED   DATA(ls_mapped_modify)
   FAILED   DATA(lt_failed_modify)
   REPORTED DATA(lt_reported_modify).

* if a new laptop is ordered, trigger a new purchase requisition
    IF lt_failed_modify IS INITIAL.
      MODIFY ENTITIES OF zad_i_online_shop IN LOCAL MODE
      ENTITY Online_Shop EXECUTE create_pr FROM CORRESPONDING #( keys )
      FAILED DATA(lt_pr_failed)
      REPORTED DATA(lt_pr_reported).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
