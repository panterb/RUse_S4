@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension Node: I-View TP'
define view entity ZAD_I_extnodetp as projection on zad_r_extnodetp 

{ 

key ID,
FreeTextComment,
ChangedOn,
  _Root: redirected to parent ZAD_I_ORDERINGTP
 
}
