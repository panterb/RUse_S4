@AbapCatalog.sqlViewName: 'ZADRESTRICTEDCU'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RestrictedCurrency'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZZAD_RESTRICTEDCURRENCY as select from I_CurrencyStdVH {
       key Currency,
    /* Associations */
    _Text
}
where Currency = 'EUR' or Currency = 'DKK' or Currency = 'SEK' 
