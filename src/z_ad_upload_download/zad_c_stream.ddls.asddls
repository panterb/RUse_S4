@EndUserText.label: 'Consumption View'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@ObjectModel.semanticKey: ['Description']

@UI: { headerInfo: { typeName: 'File',
                     typeNamePlural: 'File Upload',
                     title: { type: #STANDARD,
                              value: 'Description' } },
       presentationVariant: [{ sortOrder: [{ by: 'Uuid', direction: #ASC }], visualizations: [{type: #AS_LINEITEM}] }] }
       
       
define root view entity ZAD_C_STREAM provider contract transactional_query 
as projection on ZAD_I_STREAM 
{

          @UI.facet: [{ type: #IDENTIFICATION_REFERENCE, label: 'My File' }]

  key     Uuid,

          @UI: { lineItem:       [{ position: 10, label: 'Description' }], 
                 identification: [{ position: 10, label: 'Description' }] } 
          Description,

          @UI: { lineItem:       [{ position: 20, label: 'File' }],
                 identification: [{ position: 20, label: 'File' }] }
          @Semantics.largeObject.mimeType: 'MimeType'
          @Semantics.largeObject.fileName: 'FileName'
          @Semantics.largeObject.contentDispositionPreference: #INLINE
          FileContent,

          @UI: { lineItem:       [{ position: 30, label: 'Mime Type' }],
                 identification: [{ position: 30, label: 'Mime Type' }] }
          @Semantics.mimeType: true
          MimeType,


          @UI: { lineItem:       [{ position: 40, label: 'Filename' }],
                 identification: [{ position: 40, label: 'Filename' }] }
         FileName,
 
         ChangedOn,
         
         totaletag
  
  
}
