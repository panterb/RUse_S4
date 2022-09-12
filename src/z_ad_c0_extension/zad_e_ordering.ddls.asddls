@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility:{ extensible: true, dataSources: ['Persistence'], elementSuffix: 'YAP', 
                             quota:{ maximumBytes: 1000, maximumFields: 100 } }
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ordering: UI Projection View'

define view entity ZAD_E_ORDERING as select from zad_ordering1 as Persistence {
  key Persistence.key1 as Key1,
  curr1 as Curr1
}

