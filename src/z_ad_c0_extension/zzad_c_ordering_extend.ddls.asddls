extend view entity ZAD_C_ORDERING with 
 
{

                             
    @UI.identification:    [  { position: 1 } 
                             ,{ type: #FOR_ACTION, dataAction: 'zzad_update_deliverydate', label: 'Update Delivery Date' }]
                          
                              
     @EndUserText: { label: '!! C Field' }
    Alias_R_OrderingTP.zz_char_field_yap as zz_char_field_yap,
    
     @Consumption.valueHelpDefinition: [ {entity: {name: 'I_CurrencyStdVH', element: 'Currency' }} ] 
     @EndUserText: { label: '!! Currency' }
    Alias_R_OrderingTP.zz_curr_field1_yap as zz_curr_field1_yap,
    
    Alias_R_OrderingTP.zz_curr_field2_yap as zz_curr_field2_yap,
 
    @EndUserText: { label: '!! Display 1' }
    Alias_R_OrderingTP.zz_display1_yap as zz_display1_yap,
    
    
                           
       @UI.facet: [
      {
        id:            'NodeExtensionItem',
        purpose:       #STANDARD,
        type:          #LINEITEM_REFERENCE,
        label:         'Node Extension Item',
        position:      20,
        targetElement: '_zz_ExtNodeYAP'
      }
    ] 
    
   Alias_R_OrderingTP._zz_ExtNodeYAP : redirected to composition child ZAD_C_extnodetp
      
    
}
