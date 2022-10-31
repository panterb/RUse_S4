@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Extension Node: C-View TP'

define view entity ZAD_C_extnodetp as projection on zad_r_extnodetp 

{ 

key ID,
FreeTextComment
//_Root: redirected to parent ZAD_C_ORDERING
 
}
