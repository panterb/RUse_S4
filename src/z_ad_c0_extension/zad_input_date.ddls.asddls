@EndUserText.label: 'Delivery Date'
define abstract entity zad_input_date
{

  @Consumption.semanticObject: 'I_Currency'
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'I_CurrencyStdVH',
      element: 'Currency'
    }
  }]
  @EndUserText.label: 'Delivery Date'
  deliverydate  : abap.dats;

}
