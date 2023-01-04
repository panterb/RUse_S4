define abstract entity zad_xco_report 
{
      @Semantics.largeObject.mimeType: 'ExcelMimetype'
      @Semantics.largeObject.fileName: 'ExcelFilename'
      @Semantics.largeObject.contentDispositionPreference: #INLINE
      Excel : abap.rawstring( 0 );

      @Semantics.mimeType: true
      @UI.hidden: true
      ExcelMimetype : abap.char(128);

      @UI.hidden: true
      ExcelFilename : abap.char(128);
}
