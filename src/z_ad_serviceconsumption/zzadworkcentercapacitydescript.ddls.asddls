/********** GENERATED on 25.08.2022 at 13:28:18 by CB9980000208**************/
 @OData.entitySet.name: 'WorkCenterCapacityDescription' 
 @OData.entityType.name: 'WorkCenterCapacityDescriptionType' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZZADWORKCENTERCAPACITYDESCRIPT { 
 key WorkCenterInternalID : abap.numc( 8 ) ; 
 key WorkCenterTypeCode : abap.char( 2 ) ; 
 key CapacityCategoryAllocation : abap.numc( 4 ) ; 
 key CapacityInternalID : abap.numc( 8 ) ; 
 key Language : abap.char( 2 ) ; 
 CapacityText : abap.char( 40 ) ; 
 @Odata.property.valueControl: 'CapacityLastChangeDateTime_vc' 
 CapacityLastChangeDateTime : tzntstmpl ; 
 CapacityLastChangeDateTime_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 @OData.property.name: '_CapHeader' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __CapHeader : association [0..*] to ZZADWORKCENTERCAPACITY on 1 = 1; 
 @OData.property.name: '_Header' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 __Header1 : association [1] to ZZADWORKCENTERHEADER on 1 = 1; 
 } 
