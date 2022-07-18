@EndUserText.label: 'Variant table Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_VariantTable_S
  as select from I_Language
    left outer join ZAD_BUSCONF on 0 = 0
  composition [0..*] of ZI_VariantTable as _VariantTable
{
  key 1 as SingletonID,
  _VariantTable,
  max( ZAD_BUSCONF.CHANGED_ON ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
