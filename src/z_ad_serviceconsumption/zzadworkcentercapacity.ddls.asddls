/********** GENERATED on 25.08.2022 at 13:28:16 by CB9980000208**************/
 @OData.entitySet.name: 'WorkCenterCapacity' 
 @OData.entityType.name: 'WorkCenterCapacityType' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZZADWORKCENTERCAPACITY { 
 key WorkCenterInternalID : abap.numc( 8 ) ; 
 key WorkCenterTypeCode : abap.char( 2 ) ; 
 key CapacityCategoryAllocation : abap.numc( 4 ) ; 
 key CapacityInternalID : abap.numc( 8 ) ; 
 @Odata.property.valueControl: 'LastChangeDate_vc' 
 LastChangeDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 LastChangeDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 LastChangedByUser : abap.char( 12 ) ; 
 WorkCenter : abap.char( 8 ) ; 
 WorkCenterCategoryCode : abap.char( 4 ) ; 
 SetupCapRequirementFormula : abap.char( 6 ) ; 
 ProcgCapRequirementFormula : abap.char( 6 ) ; 
 TeardownCapRequirementFormula : abap.char( 6 ) ; 
 OtherCapRequirementFormula : abap.char( 6 ) ; 
 @Odata.property.valueControl: 'ValidityStartDate_vc' 
 ValidityStartDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 ValidityStartDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ValidityEndDate_vc' 
 ValidityEndDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 ValidityEndDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'WorkCenterLastChangeDateTim_vc' 
 WorkCenterLastChangeDateTime : tzntstmpl ; 
 WorkCenterLastChangeDateTim_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 Capacity : abap.char( 8 ) ; 
 CapacityCategoryCode : abap.char( 3 ) ; 
 CapacityActiveVersion : abap.numc( 2 ) ; 
 CapacityIsFinite : abap_boolean ; 
 CapacityIsPooled : abap_boolean ; 
 CapacityHasIndivCapacities : abap_boolean ; 
 CapacityIsExcldFrmLongTermPlng : abap_boolean ; 
 CapacityNumberOfCapacities : abap.int2 ; 
 CapacityResponsiblePlanner : abap.char( 3 ) ; 
 CapacityPlanUtilizationPercent : abap.numc( 3 ) ; 
 CapacityBreakDuration : abap.int4 ; 
 Plant : abap.char( 4 ) ; 
 FactoryCalendar : abap.char( 2 ) ; 
 AuthorizationGroup : abap.char( 4 ) ; 
 ShiftGroup : abap.char( 2 ) ; 
 CapacityStartTimeID : abap.int4 ; 
 CapacityEndTimeID : abap.int4 ; 
 CapIsUsedInMultiOperations : abap_boolean ; 
 ReferencedCapacityInternalID : abap.numc( 8 ) ; 
 CapOverloadThresholdInPercent : abap.numc( 3 ) ; 
 CapacityQuantityUnit : abap.char( 3 ) ; 
 CapacityBaseQtyUnit : abap.char( 3 ) ; 
 @Odata.property.valueControl: 'CapacityLastChangeDateTime_vc' 
 CapacityLastChangeDateTime : tzntstmpl ; 
 CapacityLastChangeDateTime_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 @OData.property.name: '_CapDescription' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __CapDescription : association [0..*] to ZZADWORKCENTERCAPACITYDESCRIPT on 1 = 1; 
 @OData.property.name: '_Header' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Header : association [1] to ZZADWORKCENTERHEADER on 1 = 1; 
 @OData.property.name: '_Interval' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Interval : association [1] to ZZADWORKCENTERCAPACITYINTERVAL on 1 = 1; 
 } 
