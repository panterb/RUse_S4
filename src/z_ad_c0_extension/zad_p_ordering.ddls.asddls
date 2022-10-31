@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ordering: Private View'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZAD_P_ORDERING as select from zad_ordering {
  
  key key1      as Key1,
  order_id      as Order_id,
  ordereditem    as OrderedItem,
  deliverydate   as Deliverydate,
  creationdate   as Creationdate,
  product_price  as product_price,
  lastchangedat  as Lastchangedat,
  curr1          as Curr1
}

