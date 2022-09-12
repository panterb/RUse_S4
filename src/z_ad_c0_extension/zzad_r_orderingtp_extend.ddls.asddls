extend view entity  ZAD_R_ORDERINGTP with 

association [0..1] to zad_i_ordering      as _zz_ExtensionYAP         on  $projection.Key1 = _zz_ExtensionYAP.Key1
composition [0..1] of zad_r_extnodetp     as _zz_ExtNodeYAP


{

    _zz_ExtNodeYAP,
    _Extension.zz_char_field_yap as zz_char_field_yap,
    _Extension.zz_curr_field1_yap as zz_curr_field1_yap,
    _Extension.zz_curr_field2_yap as zz_curr_field2_yap,
    
    cast ( case when Alias_I_Ordering.Cfield1 = ''  then 'X' else ' ' end    
                   as abap.char(1) )    as zz_display1_yap,
     _zz_ExtensionYAP
}

