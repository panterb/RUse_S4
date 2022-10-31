@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility:{ extensible: true, dataSources: ['Alias_R_ORDERINGTP'], elementSuffix: 'ZSH', 
                             quota:{ maximumBytes: 1000, maximumFields: 100 } }
@AbapCatalog.extensibility.allowNewCompositions
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ordering: Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{ serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define root view entity ZAD_I_ORDERINGTP provider contract transactional_interface
 as projection on ZAD_R_ORDERINGTP as Alias_R_ORDERINGTP
 
{

   key Key1 as Key1,
   Order_Id as Order_Id,
   Ordereditem as Ordereditem,
   Deliverydate       as Deliverydate,  
   Creationdate       as Creationdate,
   product_price      as product_price,
   Lastchangedat      as Lastchangedat,
   Curr1              as Curr1
}

