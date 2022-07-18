@EndUserText.label: 'Variant table - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_VariantTable
  as projection on ZI_VariantTable
{
  key Zadvariant,
  @Consumption.hidden: true
  Created,
  @Consumption.hidden: true
  ChangedOn,
  @Consumption.hidden: true
  SingletonID,
  _VariantTableAll : redirected to parent ZC_VariantTable_S
  
}
