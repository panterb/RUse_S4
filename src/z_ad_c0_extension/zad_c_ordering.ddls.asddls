@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility:{ extensible: true, dataSources: ['Alias_R_OrderingTP','_Extension'], elementSuffix: 'ZSH', 
                             quota:{ maximumBytes: 1000, maximumFields: 100 } }
@AbapCatalog.extensibility.allowNewCompositions
@EndUserText.label: 'Ordering: UI Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
@UI: { headerInfo: { typeName: 'Electronic Shop',
                     typeNamePlural: 'Electronic Shop',
                     title: { type: #STANDARD, label: 'Electronic Shop', value: 'order_id' } },

       presentationVariant: [{ sortOrder: [{ by: 'Creationdate',
                                             direction: #DESC }] }] }


define root view entity ZAD_C_ORDERING provider contract transactional_query as projection on ZAD_R_ORDERINGTP as Alias_R_OrderingTP

  association [0..1] to ZAD_E_ORDERING        as _Extension                  on  Alias_R_OrderingTP.Key1 = _Extension.Key1
  
{
     
        @UI: { lineItem:       [ { position: 20,label: 'Key', importance: #HIGH } ],
             identification: [ { position: 20, label: 'Key' } ] }
       key Key1 ,

     @UI.facet: [          { id:                  'Orders',
                                   purpose:         #STANDARD,
                                   type:            #IDENTIFICATION_REFERENCE,
                                   label:           'Order',
                                   position:        10 }      ]

      @UI: { lineItem:       [ { position: 20,label: 'Order ID', importance: #HIGH } ],
              identification: [ { position: 20, label: 'Order ID' } ] }
      @Search.defaultSearchElement: true
      Order_Id,   
      
       
              
      @UI: { lineItem:       [ { position: 20,label: 'Ordered item', importance: #HIGH } ],
              identification: [ { position: 20, label: 'Ordered item' } ] }
      @Search.defaultSearchElement: true
      Ordereditem,
      
      @UI: { lineItem:       [ { position: 50,label: 'Delivery date', importance: #HIGH } ],
      identification: [ { position: 50, label: 'Delievery date' } ] }
       Deliverydate       as Deliverydate,
      
      @UI: { lineItem:       [ { position: 50,label: 'Creation date', importance: #HIGH } ],
             identification: [ { position: 50, label: 'Creation date' } ] }
       Creationdate       as Creationdate,
  
      @UI: { lineItem:       [ { position: 50,label: 'Price', importance: #HIGH } ],
             identification: [ { position: 50, label: 'Price' } ] }
      product_price   as product_price,
      
      @UI: { lineItem:       [ { position: 50,label: 'Currency', importance: #HIGH } ],
      identification: [ { position: 50, label: 'Currency' } ] }
      @Consumption.valueHelpDefinition: [ {entity: {name: 'I_CurrencyStdVH', element: 'Currency' }} ]
      Curr1   as Curr1

}

