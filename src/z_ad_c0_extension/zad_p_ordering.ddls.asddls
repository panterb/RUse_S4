@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ordering: Private View'
--@Metadata.ignorePropagatedAnnotations: true
--@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZAD_P_ORDERING as select from zad_ordering1 {
  
  key key1      as Key1,
  order_id      as Order_id,
  ordereditem    as OrderedItem,
  deliverydate   as Deliverydate,
  creationdate   as Creationdate,
  cfield1        as Cfield1,
  lastchangedat  as Lastchangedat,
  curr1          as Curr1
}

