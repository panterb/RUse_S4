@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility.extensible: true
@AbapCatalog.extensibility.dataSources: ['_Extension'] 
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ordering: Core View'
--@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.extensibility.allowNewCompositions
@Metadata.allowExtensions: true
@ObjectModel.usageType:{ serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity zad_i_ordering as select from ZAD_P_ORDERING 

//Extensibility
  association [0..1] to ZAD_E_ORDERING        as _Extension                  on  ZAD_P_ORDERING.Key1 = _Extension.Key1
{

   key Key1 as Key1,
   Order_id as Order_Id,
   OrderedItem as Ordereditem,
   Cfield1   as Cfield1,
   Deliverydate       as Deliverydate, 
   Creationdate       as Creationdate,
   Lastchangedat      as Lastchangedat,
   Curr1              as Curr1
}

