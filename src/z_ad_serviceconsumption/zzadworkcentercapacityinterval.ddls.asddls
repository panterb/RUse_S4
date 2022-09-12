/********** GENERATED on 25.08.2022 at 13:28:19 by CB9980000208**************/
 @OData.entitySet.name: 'WorkCenterCapacityInterval' 
 @OData.entityType.name: 'WorkCenterCapacityIntervalType' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZZADWORKCENTERCAPACITYINTERVAL { 
 key WorkCenterInternalID : abap.numc( 8 ) ; 
 key WorkCenterTypeCode : abap.char( 2 ) ; 
 key CapacityCategoryAllocation : abap.numc( 4 ) ; 
 key CapacityInternalID : abap.numc( 8 ) ; 
 key CapacityActiveVersion : abap.numc( 2 ) ; 
 key IntervalEndDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 IntervalStartDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 StdAvailableCapacityIsValid : abap_boolean ; 
 AvailableCapacityIntervalDurn : abap.numc( 2 ) ; 
 ShiftSequence : abap.char( 4 ) ; 
 WorkDayRule : abap.char( 1 ) ; 
 CapacityNumberOfShifts : abap.numc( 1 ) ; 
 CapacityNumberOfCapacities : abap.int2 ; 
 CapacityPlanUtilizationPercent : abap.numc( 3 ) ; 
 @Odata.property.valueControl: 'CapacityLastChangeDateTime_vc' 
 CapacityLastChangeDateTime : tzntstmpl ; 
 CapacityLastChangeDateTime_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 @OData.property.name: '_CapHeader' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __CapHeader1 : association [0..*] to ZZADWORKCENTERCAPACITY on 1 = 1; 
 @OData.property.name: '_Header' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Header12 : association [1] to ZZADWORKCENTERHEADER on 1 = 1; 
 @OData.property.name: '_Shift' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Shift : association [0..*] to ZZADWORKCENTERCAPACITYSHIFT on 1 = 1; 
 } 
