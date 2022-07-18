@EndUserText.label: 'Variant table'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_VariantTable
  as select from ZAD_BUSCONF
  association to parent ZI_VariantTable_S as _VariantTableAll on $projection.SingletonID = _VariantTableAll.SingletonID
{
  key ZADVARIANT as Zadvariant,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  CREATED as Created,
  @Semantics.systemDateTime.lastChangedAt: true
  CHANGED_ON as ChangedOn,
  1 as SingletonID,
  _VariantTableAll
  
}
