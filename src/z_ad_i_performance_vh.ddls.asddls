@AbapCatalog.sqlViewName: 'Z_AD_VPERFVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Performance'

@Search.searchable: true
@ObjectModel.dataCategory: #TEXT
@ObjectModel.resultSet.sizeCategory: #XS

define view z_ad_i_performance_vh as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'Z_AD_PERFORMANCE' ) 
  association [0..*] to z_ad_i_performance_vh as _Performance on $projection.Id = _Performance.Id
{
      //DDCDS_CUSTOMER_DOMAIN_VALUE_T
  key domain_name,
  key value_position,
      @Semantics.language
  key language,

      @ObjectModel.text.element: ['Text']
  key value_low as Id,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @Semantics.text: true
      text      as Text,

      _Performance
}
where language = $session.system_language
