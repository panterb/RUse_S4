extend view entity  ZAD_R_ORDERINGTP with 

association [0..1] to zad_i_ordering      as _zz_ExtensionZSH         on  $projection.Key1 = _zz_ExtensionZSH.Key1



{

    _Extension.zz_char_field_zsh as zz_char_field_zsh,
    _Extension.zz_curr_field1_zsh as zz_curr_field1_zsh,
    _Extension.zz_curr_field2_zsh as zz_curr_field2_zsh,

     _zz_ExtensionZSH
}

