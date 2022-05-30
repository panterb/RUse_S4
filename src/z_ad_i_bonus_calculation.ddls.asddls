@AccessControl.authorizationCheck: #CHECK

@AbapCatalog.extensibility: {
  extensible: true,
  dataSources: ['bonusclc']
}

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity z_ad_i_bonus_calculation 
as select from zadbonusclc as bonusclc 

  association [0..*] to I_CurrencyText           as _TargetAmountText        on _TargetAmountText.Currency = $projection.TargetAmount_C
  association [0..*] to I_UnitOfMeasureText      as _BonusRateText           on _BonusRateText.UnitOfMeasure = $projection.BonusRate_U
  association [0..*] to I_CurrencyText           as _ActualRevenueAmountText on _ActualRevenueAmountText.Currency = $projection.ActualRevenueAmount_C
  association [0..*] to I_CurrencyText           as _BonusAmountText         on _BonusAmountText.Currency = $projection.BonusAmount_C
  association [0..1] to z_ad_i_performance_vh as _PerformanceText            on _PerformanceText.Id = $projection.Performance
                                                                             and _PerformanceText.language = $session.system_language
  // association [0..*] to /itapc1/1911_bonus_chdo as _Changes                 on _Changes.BonusID                   = $projection.ID

  association [0..1] to I_User                   as _user                    on $projection.CreatedBy = _user.UserID

  association [0..1] to z_ad_i_bonus_variants    as _BonusVariant            on $projection.BonusVariant = _BonusVariant.BonusVariant


{
   key id                          as ID,

      //Employee
      employeeid                  as EmployeeID,

      employeename                as EmployeeName,

      //Validity
      validitystartdate           as ValidityStartDate,

      validityenddate             as ValidityEndDate,

      //Bonus Variant
      bonusvariant                as BonusVariant,

      _BonusVariant.Description   as BonusDescription,

      _BonusVariant.BonusCategory as BonusCategory,

      _BonusVariant.BonusScaling  as BonusScaling,

      _BonusVariant.LowerLimit    as TargetLowerLimit,

      _BonusVariant.UpperLimit    as TargetUpperLimit,

      //Revenue

      targetamount_v              as TargetAmount_V,

      targetamount_c              as TargetAmount_C,

      actualrevenueamount_v       as ActualRevenueAmount_V,

      actualrevenueamount_c       as ActualRevenueAmount_C,

      //Rate-based bonus variant
      bonusrate_v                 as BonusRate_V,

      bonusrate_u                 as BonusRate_U,

      //Amount-based bonus variant
      rawbonusamount_v            as RawBonusAmount_V,

      rawbonusamount_c            as RawBonusAmount_C,

      //Final Bonus
      bonusamount_v               as BonusAmount_V,

      bonusamount_c               as BonusAmount_C,

      bonusamount_w               as BonusAmount_W,

      case
        when actualrevenueamount_v is initial then 0
        when actualrevenueamount_v = targetamount_v then 2
        when actualrevenueamount_v < targetamount_v then 1
        else 3
      end                         as PerformanceIndicator,

      case
        when actualrevenueamount_v is initial then '0'
        when actualrevenueamount_v = targetamount_v then '2'
        when actualrevenueamount_v < targetamount_v then '1'
        else '3'
      end                         as Performance,

      @Semantics.user.createdBy: true
      createdby                   as CreatedBy,
      _user.UserDescription       as CreatedByUser,
      @Semantics.systemDateTime.createdAt: true
      createdat                   as CreatedAt,
      @Semantics.user.lastChangedBy: true
      lastchangedby               as LastChangedBy,
      _user.UserDescription       as LastChangedByUser,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat               as LastChangedAt,

      _TargetAmountText,
      _BonusRateText,
      _ActualRevenueAmountText,
      _BonusAmountText,
//      _BonusVariant,
      _PerformanceText
      //      _Changes
}
