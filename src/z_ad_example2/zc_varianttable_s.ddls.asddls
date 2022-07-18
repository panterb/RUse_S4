@EndUserText.label: 'Variant table Singleton - Maintain'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_VariantTable_S
  provider contract transactional_query
  as projection on ZI_VariantTable_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _VariantTable : redirected to composition child ZC_VariantTable
  
}
