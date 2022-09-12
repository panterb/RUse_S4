@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data model for online shop'
define root view entity ZAD_I_ONLINE_SHOP
  as select from zad_online_shop
  association [1..1] to Zad_I_ONSHOP_ADD as _purchase_req on $projection.Order_Uuid = _purchase_req.OrderUuid
{

  key order_uuid   as Order_Uuid,
      order_id     as Order_Id,
      ordereditem  as Ordereditem,
      deliverydate as Deliverydate,
      creationdate as Creationdate,
      _purchase_req

}
