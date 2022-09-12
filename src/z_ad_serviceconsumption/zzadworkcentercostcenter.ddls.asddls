/********** GENERATED on 25.08.2022 at 13:28:21 by CB9980000208**************/
 @OData.entitySet.name: 'WorkCenterCostCenter' 
 @OData.entityType.name: 'WorkCenterCostCenterType' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZZADWORKCENTERCOSTCENTER { 
 key WorkCenterInternalID : abap.numc( 8 ) ; 
 key WorkCenterTypeCode : abap.char( 2 ) ; 
 key CostCenterAllocation : abap.numc( 4 ) ; 
 key ValidityEndDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 ValidityStartDate : RAP_CP_ODATA_V4_EDM_DATE ; 
 WorkCenter : abap.char( 8 ) ; 
 Plant : abap.char( 4 ) ; 
 WorkCenterCategoryCode : abap.char( 4 ) ; 
 ControllingArea : abap.char( 4 ) ; 
 CostCenter : abap.char( 10 ) ; 
 CostCtrActivityType : abap.char( 6 ) ; 
 CostCtrActivityTypeQtyUnit : abap.char( 3 ) ; 
 BusinessProcess : abap.char( 12 ) ; 
 ActivityDescOriginType : abap.char( 1 ) ; 
 CostCenterActivityAltvDescID : abap.char( 4 ) ; 
 CostCenterActivityTypeFormula : abap.char( 6 ) ; 
 CostCtrActyTypeIsReferenced : abap_boolean ; 
 CostCtrActyTypeIncntvWageCode : abap.char( 1 ) ; 
 CostCtrActyTypeRecdTypeGrpCode : abap.numc( 1 ) ; 
 @Odata.property.valueControl: 'WorkCenterLastChangeDateTim_vc' 
 WorkCenterLastChangeDateTime : tzntstmpl ; 
 WorkCenterLastChangeDateTim_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 @OData.property.name: '_Header' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Header1234 : association [1] to ZZADWORKCENTERHEADER on 1 = 1; 
 } 
