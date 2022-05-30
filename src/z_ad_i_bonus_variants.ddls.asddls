@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.sqlViewName: 'Z_AD_BVAR'
@EndUserText.label: 'Interface view bonus variants'
@ObjectModel.semanticKey: ['BonusVariant']

define view z_ad_i_bonus_variants 
   as select from zadbonusvar
     
   association [0..1] to I_User                       as _user                   on  $projection.CreatedBy = _user.UserID
   
{

  key zadvariant                  as BonusVariant,
      1                           as BonusVariantAllID,
      category                    as BonusCategory,
      lowerlimit                  as LowerLimit,
      upperlimit                  as UpperLimit,
      scaling                     as BonusScaling,
      description                 as Description,

      @Semantics.user.createdBy: true
      createdby                   as CreatedBy,
      _user.UserDescription       as CreatedByUser,
      @Semantics.systemDateTime.createdAt: true
      createdat                   as CreatedAt,

      @Semantics.user.lastChangedBy: true
      changedby                   as ChangedBy,
      _user.UserDescription       as ChangedByUser,
      @Semantics.systemDateTime.lastChangedAt: true
      changedat                   as ChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at,

      creation                    as TypeOfCreation,

      configdeprecationcode       as ConfigDeprecationCode,
      case when configdeprecationcode = 'W' then 2
           when configdeprecationcode = 'E' then 1
           else 3
      end                         as criticality

//      cast( '' as sxco_transport) as Request,
//      cast( 'X' as abap_boolean)  as HideTransport,

//      _BonusCategory,
//      _BonusScaling,
//      _DeprecationText,
//      _BonusVariantTxt,
//      _BonusVariantAll

}
   
