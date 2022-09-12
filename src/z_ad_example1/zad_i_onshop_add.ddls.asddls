@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for online shop'
define root view entity Zad_I_ONSHOP_ADD
  as select from zad_onshop_ad
{
  key order_uuid    as OrderUuid,
      purchasereqn  as Purchasereqn,
      purinforecord as Purinforecord,
      purorder      as Purorder
}
