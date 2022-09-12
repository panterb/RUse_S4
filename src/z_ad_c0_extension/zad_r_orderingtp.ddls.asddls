@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility:{ extensible: true, dataSources: ['Alias_I_Ordering', '_Interface', '_Extension'], elementSuffix: 'YAP', 
                             quota:{ maximumBytes: 1000, maximumFields: 100 } }
@AbapCatalog.extensibility.allowNewCompositions
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ordering: Private View'
--@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ZAD_R_ORDERINGTP as select from zad_i_ordering as Alias_I_Ordering 
  //Extensibility
  association [0..1] to ZAD_E_ORDERING      as _Extension                  on  $projection.Key1 = _Extension.Key1
  association [0..1] to zad_i_ordering      as _Interface                  on  $projection.Key1 = _Interface.Key1

{
  
   key Key1 as Key1,
   Order_Id as Order_Id,
   Ordereditem as Ordereditem,
   Deliverydate       as Deliverydate,  
   Creationdate       as Creationdate,
   Lastchangedat      as Lastchangedat,   
   Cfield1            as Cfield1,
   Curr1              as Curr1,
   _Interface
}

