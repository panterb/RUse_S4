@EndUserText.label: 'Interface View'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZAD_I_STREAM as select from zad_stream 
{
  key uuid as Uuid,
      description as Description,
  
      file_content        as FileContent,
  
       @Semantics.mimeType: true
      mime_type   as MimeType,

      file_name   as FileName,
      
      @Semantics.systemDateTime.lastChangedAt: true
      changed_on as ChangedOn,
      
 
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      totaletag     as totaletag
  
}
