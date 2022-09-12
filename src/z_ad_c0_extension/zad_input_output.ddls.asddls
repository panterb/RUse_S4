@EndUserText.label: 'Parameter'
define abstract entity Zad_input_output
{

  @EndUserText.label: 'Number'
  num1  : abap.int4;

  @Consumption.semanticObject: 'I_Currency'
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'I_CurrencyStdVH',
      element: 'Currency'
    }
  }]
  @EndUserText.label: 'Currency'
  //@ObjectModel.mandatory: true
  curr1 : abap.cuky;

}
