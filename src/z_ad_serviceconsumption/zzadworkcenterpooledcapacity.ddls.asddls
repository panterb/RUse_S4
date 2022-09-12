/********** GENERATED on 25.08.2022 at 13:28:23 by CB9980000208**************/
 @OData.entitySet.name: 'WorkCenterPooledCapacity' 
 @OData.entityType.name: 'WorkCenterPooledCapacityType' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZZADWORKCENTERPOOLEDCAPACITY { 
 key WorkCenterInternalID : abap.numc( 8 ) ; 
 key WorkCenterTypeCode : abap.char( 2 ) ; 
 key CapacityCategoryAllocation : abap.numc( 4 ) ; 
 key CapacityInternalID : abap.numc( 8 ) ; 
 @Odata.property.valueControl: 'LastChangeDate_vc' 
 LastChangeDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 LastChangeDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 LastChangedByUser : abap.char( 12 ) ; 
 Plant : abap.char( 4 ) ; 
 WorkCenter : abap.char( 8 ) ; 
 WorkCenterCategoryCode : abap.char( 4 ) ; 
 CapacityCategoryCode : abap.char( 3 ) ; 
 Capacity : abap.char( 8 ) ; 
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
 
 @OData.property.name: '_Header' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Header123456 : association [1] to ZZADWORKCENTERHEADER on 1 = 1; 
 } 
