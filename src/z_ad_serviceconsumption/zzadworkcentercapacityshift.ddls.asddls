/********** GENERATED on 25.08.2022 at 13:28:20 by CB9980000208**************/
 @OData.entitySet.name: 'WorkCenterCapacityShift' 
 @OData.entityType.name: 'WorkCenterCapacityShiftType' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZZADWORKCENTERCAPACITYSHIFT { 
 key WorkCenterInternalID : abap.numc( 8 ) ; 
 key WorkCenterTypeCode : abap.char( 2 ) ; 
 key CapacityCategoryAllocation : abap.numc( 4 ) ; 
 key CapacityInternalID : abap.numc( 8 ) ; 
 key CapacityActiveVersion : abap.numc( 2 ) ; 
 key IntervalEndDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 key WeekDay : abap.numc( 1 ) ; 
 key AvailableCapacityShift : abap.numc( 1 ) ; 
 @Odata.property.valueControl: 'IntervalStartDate_vc' 
 IntervalStartDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 IntervalStartDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 WorkDayRule : abap.char( 1 ) ; 
 ShiftDefinition : abap.char( 4 ) ; 
 ShiftStartTime : RAP_CP_ODATA_V4_EDM_TIMEOFDAY ; 
 ShiftEndTime : RAP_CP_ODATA_V4_EDM_TIMEOFDAY ; 
 @Odata.property.valueControl: 'ShiftDefValidityStartDate_vc' 
 ShiftDefValidityStartDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 ShiftDefValidityStartDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ShiftDefValidityEndDate_vc' 
 ShiftDefValidityEndDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 ShiftDefValidityEndDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 CapacityNumberOfCapacities : abap.int2 ; 
 CapacityPlanUtilizationPercent : abap.numc( 3 ) ; 
 CapacityBreakDuration : abap.int4 ; 
 OperatingDurationInSeconds : abap.int4 ; 
 TotOperatingDurationInSeconds : abap.int4 ; 
 @Odata.property.valueControl: 'CapacityLastChangeDateTime_vc' 
 CapacityLastChangeDateTime : tzntstmpl ; 
 CapacityLastChangeDateTime_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 @OData.property.name: '_Header' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Header123 : association [1] to ZZADWORKCENTERHEADER on 1 = 1; 
 @OData.property.name: '_Interval' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Interval1 : association [1] to ZZADWORKCENTERCAPACITYINTERVAL on 1 = 1; 
 } 
