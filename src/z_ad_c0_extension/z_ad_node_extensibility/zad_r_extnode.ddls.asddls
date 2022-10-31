@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility.allowNewCompositions
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ordring: Private View'
--@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZAD_R_EXTNODE as select from zad_ext_node 
//  association to parent ZAD_R_ORDERINGTP      as _Root     on  $projection.Id = _Root.Key1  
{  
   key id as Id,
   changed_on
 //  _Root
}
