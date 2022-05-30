@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data model for online shop'
define root view entity ZAD_I_ONLINE_SHOP as select from zad_online_shop
 {
    
   key order_uuid as Order_Uuid,
   order_id as Order_Id,
   ordereditem as Ordereditem,
   deliverydate as Deliverydate,
   creationdate as Creationdate

}
