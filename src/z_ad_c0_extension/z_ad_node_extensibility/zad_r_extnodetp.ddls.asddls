@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label:  'Extension Node: R-View TP'
define view entity  zad_r_extnodetp as select from ZAD_I_extnode 
   association to parent ZAD_R_ORDERINGTP      as _Root     on  $projection.ID = _Root.Key1
{  
  key ID,
  FreeTextComment,
  ChangedOn,
  _Root   
}
