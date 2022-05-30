@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bonus Calculation Projection View'

@Search: { searchable: true }
@ObjectModel.semanticKey: ['EmployeeID']
@Metadata.allowExtensions: true

@AbapCatalog.extensibility: {
  extensible: true,
  dataSources: ['Node']
}

define root view entity z_ad_c_bonus_calculation 
 provider contract transactional_query
  as projection on z_ad_i_bonus_calculation as Node

  association [0..*] to I_CurrencyText           as _TargetAmountText        on _TargetAmountText.Currency = $projection.TargetAmount_C
  association [0..*] to I_UnitOfMeasureText      as _BonusRateText           on _BonusRateText.UnitOfMeasure = $projection.BonusRate_U
  association [0..*] to I_CurrencyText           as _ActualRevenueAmountText on _ActualRevenueAmountText.Currency = $projection.ActualRevenueAmount_C
  association [0..*] to I_CurrencyText           as _BonusAmountText         on _BonusAmountText.Currency = $projection.BonusAmount_C

{
      //Node
  key ID,

      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.8 }
//      @Consumption.valueHelpDefinition: [{ entity: { name: '/itapc1/i_employee_vh', element: 'BusinessPartner' }, additionalBinding: [{element: 'BusinessPartnerFullName', localElement: 'EmployeeName', usage: #RESULT}]}]
      @Consumption.semanticObject: 'BusinessPartner'
      @ObjectModel.text.element: ['EmployeeName']
      @EndUserText.label: 'Employee'
      EmployeeID,

      @EndUserText.label: 'Employee Name'
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.8 }
      EmployeeName,
      ValidityStartDate,
      ValidityEndDate,

      @ObjectModel.text.element: ['BonusDescription']
//      @Consumption.valueHelpDefinition: [{ entity : { name: '/ITAPC1/C_VARIANTS_VIEW', element: 'BonusVariant'  }  }]
      BonusVariant,
      BonusDescription,

      @Semantics: { amount.currencyCode: 'TargetAmount_C' }
      TargetAmount_V,

      @Consumption.valueHelpDefinition: [{ entity : { name: 'I_Currency', element: 'Currency'  } }]
      @Semantics: { currencyCode: true }
      //      @ObjectModel: { text.association: '_TargetAmountText' }
      TargetAmount_C,

      @Semantics: { amount.currencyCode: 'ActualRevenueAmount_C' }
      ActualRevenueAmount_V,

      @Consumption.valueHelpDefinition: [{ entity : { name: 'I_Currency', element: 'Currency' } }]
      @Semantics: { currencyCode: true }
      //      @ObjectModel: { text.association: '_ActualRevenueAmountText' }
      ActualRevenueAmount_C,

      @Semantics: { quantity.unitOfMeasure: 'BonusRate_U' }
      BonusRate_V,

      @Consumption.valueHelpDefinition: [{ entity : { name: 'I_UnitOfMeasure', element: 'UnitOfMeasure'  } }]
      @Semantics: { unitOfMeasure: true }
      //      @ObjectModel: { text.association: '_BonusRateText' }
      BonusRate_U,

      @Semantics: { amount.currencyCode: 'BonusAmount_C' }
      BonusAmount_V,

      @EndUserText.label: 'Total Bonus Amount (in words)'
      BonusAmount_W,

      @Consumption.valueHelpDefinition: [{ entity : { name: 'I_Currency', element: 'Currency'  } }]
      @Semantics: { currencyCode: true }
      //      @ObjectModel: { text.association: '_BonusAmountText' }
      BonusAmount_C,

      @Semantics: { amount.currencyCode: 'RawBonusAmount_C' }
      RawBonusAmount_V,

      @Consumption.valueHelpDefinition: [{ entity : { name: 'I_Currency', element: 'Currency'  } }]
      @Semantics: { currencyCode: true }
      RawBonusAmount_C,

      PerformanceIndicator,
      
      @ObjectModel.text.element: ['PerformanceText']
      Performance,
      _PerformanceText.Text as PerformanceText,

      CreatedBy,
      
      @EndUserText.label: 'Created By'
      CreatedByUser,
      
      @EndUserText.label: 'Created At'
      CreatedAt,
      LastChangedBy,
      
      @EndUserText.label: 'Last Changed At'
      LastChangedAt,
      
      @EndUserText.label: 'Last Changed By'
      LastChangedByUser,
      
      /* Associations */
      //Node
      _ActualRevenueAmountText,
      _BonusAmountText,
      _BonusRateText,
      _TargetAmountText
      
      //Virtual elements to toggle visibility of bonus variant related fields
//      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/ITAPC1/CALC_VIRTUAL_ELEMENT'
//       virtual HideRateSettings : abap_boolean,
      
//       @ObjectModel.virtualElementCalculatedBy: 'ABAP:/ITAPC1/CALC_VIRTUAL_ELEMENT'
//       virtual HideAmountSettings : abap_boolean

}
 