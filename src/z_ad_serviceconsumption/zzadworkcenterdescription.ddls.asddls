/********** GENERATED on 25.08.2022 at 13:28:22 by CB9980000208**************/
 @OData.entitySet.name: 'WorkCenterDescription' 
 @OData.entityType.name: 'WorkCenterDescriptionType' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZZADWORKCENTERDESCRIPTION { 
 key WorkCenterInternalID : abap.numc( 8 ) ; 
 key WorkCenterTypeCode : abap.char( 2 ) ; 
 key Language : abap.char( 2 ) ; 
 WorkCenterDesc : abap.char( 40 ) ; 
 WorkCenter : abap.char( 8 ) ; 
 Plant : abap.char( 4 ) ; 
 WorkCenterCategoryCode : abap.char( 4 ) ; 
 @Odata.property.valueControl: 'WorkCenterLastChangeDateTim_vc' 
 WorkCenterLastChangeDateTime : tzntstmpl ; 
 WorkCenterLastChangeDateTim_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 @OData.property.name: '_Header' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Header12345 : association [1] to ZZADWORKCENTERHEADER on 1 = 1; 
 } 
