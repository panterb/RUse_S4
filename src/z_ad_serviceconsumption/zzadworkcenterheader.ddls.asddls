/********** GENERATED on 25.08.2022 at 13:28:04 by CB9980000208**************/
 @OData.entitySet.name: 'WorkCenterHeader' 
 @OData.entityType.name: 'WorkCenterHeaderType' 
 define root abstract entity ZZADWORKCENTERHEADER { 
 key WorkCenterInternalID : abap.numc( 8 ) ; 
 key WorkCenterTypeCode : abap.char( 2 ) ; 
 WorkCenter : abap.char( 8 ) ; 
 WorkCenterDesc : abap.char( 40 ) ; 
 Plant : abap.char( 4 ) ; 
 WorkCenterCategoryCode : abap.char( 4 ) ; 
 WorkCenterResponsible : abap.char( 3 ) ; 
 WorkCenterResponsibleName : abap.char( 40 ) ; 
 SupplyArea : abap.char( 10 ) ; 
 WorkCenterUsage : abap.char( 3 ) ; 
 CapacityInternalID : abap.numc( 8 ) ; 
 CapacityCategoryCode : abap.char( 3 ) ; 
 Capacity : abap.char( 8 ) ; 
 WorkCenterIsToBeDeleted : abap_boolean ; 
 @Odata.property.valueControl: 'ValidityStartDate_vc' 
 ValidityStartDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 ValidityStartDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ValidityEndDate_vc' 
 ValidityEndDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 ValidityEndDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 WorkCenterFormulaParam1 : abap.char( 6 ) ; 
 WorkCenterFormulaParam2 : abap.char( 6 ) ; 
 WorkCenterFormulaParam3 : abap.char( 6 ) ; 
 WorkCenterFormulaParam4 : abap.char( 6 ) ; 
 WorkCenterFormulaParam5 : abap.char( 6 ) ; 
 WorkCenterFormulaParam6 : abap.char( 6 ) ; 
 @Semantics.quantity.unitOfMeasure: 'WorkCenterFmlaParamUnit1' 
 WorkCenterFmlaParamValue1 : abap.dec( 9, 3 ) ; 
 @Semantics.quantity.unitOfMeasure: 'WorkCenterFmlaParamUnit2' 
 WorkCenterFmlaParamValue2 : abap.dec( 9, 3 ) ; 
 @Semantics.quantity.unitOfMeasure: 'WorkCenterFmlaParamUnit3' 
 WorkCenterFmlaParamValue3 : abap.dec( 9, 3 ) ; 
 @Semantics.quantity.unitOfMeasure: 'WorkCenterFmlaParamUnit4' 
 WorkCenterFmlaParamValue4 : abap.dec( 9, 3 ) ; 
 @Semantics.quantity.unitOfMeasure: 'WorkCenterFmlaParamUnit5' 
 WorkCenterFmlaParamValue5 : abap.dec( 9, 3 ) ; 
 @Semantics.quantity.unitOfMeasure: 'WorkCenterFmlaParamUnit6' 
 WorkCenterFmlaParamValue6 : abap.dec( 9, 3 ) ; 
 @Semantics.unitOfMeasure: true 
 WorkCenterFmlaParamUnit1 : abap.unit( 3 ) ; 
 @Semantics.unitOfMeasure: true 
 WorkCenterFmlaParamUnit2 : abap.unit( 3 ) ; 
 @Semantics.unitOfMeasure: true 
 WorkCenterFmlaParamUnit3 : abap.unit( 3 ) ; 
 @Semantics.unitOfMeasure: true 
 WorkCenterFmlaParamUnit4 : abap.unit( 3 ) ; 
 @Semantics.unitOfMeasure: true 
 WorkCenterFmlaParamUnit5 : abap.unit( 3 ) ; 
 @Semantics.unitOfMeasure: true 
 WorkCenterFmlaParamUnit6 : abap.unit( 3 ) ; 
 StandardWorkFormulaParamGroup : abap.char( 4 ) ; 
 WrkCtrStdValMaintRule1 : abap.char( 1 ) ; 
 WrkCtrStdValMaintRule2 : abap.char( 1 ) ; 
 WrkCtrStdValMaintRule3 : abap.char( 1 ) ; 
 WrkCtrStdValMaintRule4 : abap.char( 1 ) ; 
 WrkCtrStdValMaintRule5 : abap.char( 1 ) ; 
 WrkCtrStdValMaintRule6 : abap.char( 1 ) ; 
 WorkCenterStandardWorkQtyUnit1 : abap.char( 3 ) ; 
 WorkCenterStandardWorkQtyUnit2 : abap.char( 3 ) ; 
 WorkCenterStandardWorkQtyUnit3 : abap.char( 3 ) ; 
 WorkCenterStandardWorkQtyUnit4 : abap.char( 3 ) ; 
 WorkCenterStandardWorkQtyUnit5 : abap.char( 3 ) ; 
 WorkCenterStandardWorkQtyUnit6 : abap.char( 3 ) ; 
 OperationControlProfile : abap.char( 4 ) ; 
 MatlCompIsMarkedForBackflush : abap_boolean ; 
 WorkCenterLocation : abap.char( 10 ) ; 
 WorkCenterLocationGroup : abap.char( 4 ) ; 
 WrkCtrSetupSchedgFmla : abap.char( 6 ) ; 
 WrkCtrProcgSchedgFmla : abap.char( 6 ) ; 
 WrkCtrTeardownSchedgFmla : abap.char( 6 ) ; 
 WrkCtrIntProcgSchedgFmla : abap.char( 6 ) ; 
 @Odata.property.valueControl: 'WorkCenterLastChangeDateTim_vc' 
 WorkCenterLastChangeDateTime : tzntstmpl ; 
 WorkCenterLastChangeDateTim_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 @OData.property.name: '_Capacity' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Capacity : association [0..*] to ZZADWORKCENTERCAPACITY on 1 = 1; 
 @OData.property.name: '_CostCenter' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __CostCenter : association [0..*] to ZZADWORKCENTERCOSTCENTER on 1 = 1; 
 @OData.property.name: '_Description' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Description : association [0..*] to ZZADWORKCENTERDESCRIPTION on 1 = 1; 
 @OData.property.name: '_PooledCap' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __PooledCap : association [0..*] to ZZADWORKCENTERPOOLEDCAPACITY on 1 = 1; 
 } 
