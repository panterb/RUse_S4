CLASS lsc_zhb_i_online_shop_act DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

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
                                          purchaserequisitionitemtext     = 'PAAS API Test 20.05'
                                            accountassignmentcategory     = 'U'
                                          requestedquantity               = '9.00'
                                          baseunit                        = 'EA'
                                          purchaserequisitionprice        = '12.00'
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
                      %target  = VALUE #( ( CostCenter   = 'JMW-COST'
                                            GLAccount    = '0000400000' ) ) ) )
CREATE BY \_purchasereqnitemtext
   FIELDS ( plainlongtext )
   WITH VALUE #(  (   %cid_ref = 'My%ItemCID_1'
                      %target  = VALUE #( (
                                          textobjecttype = 'B01'
                                          language       = 'E'
                                          plainlongtext  = 'item text created from PAAS API 20.05 D048583'
                                        ) (
                                          textobjecttype = 'B02'
                                          language       = 'E'
                                          plainlongtext  = 'item2 text created from PAAS API 19.05'
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
    SELECT MAX( order_id ) FROM zad_online_shop INTO @DATA(max_order_id).
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
      online_shop-Deliverydate  = today + 10.
      APPEND online_shop TO online_shops.
    ENDLOOP.
    MODIFY ENTITIES OF zad_i_online_shop IN LOCAL MODE
   ENTITY online_shop UPDATE SET FIELDS WITH online_shops
   MAPPED   DATA(ls_mapped_modify)
   FAILED   DATA(lt_failed_modify)
   REPORTED DATA(lt_reported_modify).

* if a new laptop is ordered, trigger a new purschase requisition
    IF lt_failed_modify IS INITIAL.
      MODIFY ENTITIES OF zad_i_online_shop IN LOCAL MODE
      ENTITY Online_Shop EXECUTE create_pr FROM CORRESPONDING #( keys )
      FAILED DATA(lt_pr_failed)
      REPORTED DATA(lt_pr_reported).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
