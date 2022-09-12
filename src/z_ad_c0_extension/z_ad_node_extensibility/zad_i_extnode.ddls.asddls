@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension Node: Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{ serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity ZAD_I_extnode as select from zad_ext_node as ExtNode

{ 

key id as ID,
changed_on as ChangedOn,
free_text_comment as FreeTextComment

}



