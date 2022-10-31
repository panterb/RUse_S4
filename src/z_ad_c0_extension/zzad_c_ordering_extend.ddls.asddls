extend view entity ZAD_C_ORDERING with 
 
{
                             
    @UI.identification:    [  { position: 1 } 
                             ,{ type: #FOR_ACTION, dataAction: 'zzad_update_deliverydate', label: 'Update Delivery Date' }]
                          
     
    @UI: { lineItem:       [ { position: 50,label: '!! C Field', importance: #HIGH } ] }               
    @EndUserText: { label: '!! C Field' }
    Alias_R_OrderingTP.zz_char_field_zsh as zz_char_field_zsh
    
    
}
