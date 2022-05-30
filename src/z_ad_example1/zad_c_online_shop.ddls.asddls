@EndUserText.label: 'Consumtion View'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@UI: { headerInfo: { typeName: 'Online Shop',
                     typeNamePlural: 'Online Shop',
                     title: { type: #STANDARD, label: 'Online Shop', value: 'order_id' } },

       presentationVariant: [{ sortOrder: [{ by: 'Creationdate',
                                             direction: #DESC }] }] }
                                             
define root view entity ZAD_C_online_shop provider contract transactional_query
as projection on ZAD_I_ONLINE_SHOP 
{
      @UI.facet: [          { id:                  'Orders',
                                   purpose:         #STANDARD,
                                   type:            #IDENTIFICATION_REFERENCE,
                                   label:           'Order',
                                   position:        10 }      ]
  key Order_Uuid,
      @UI: { lineItem:       [ { position: 10,label: 'Order id', importance: #HIGH } ],
               identification: [ { position: 10, label: 'order id' } ] }
      @Search.defaultSearchElement: true
      Order_Id,
      @UI: { lineItem:       [ { position: 20,label: 'Ordered item', importance: #HIGH } ],
              identification: [ { position: 20, label: 'Ordered item' } ] }
      @Search.defaultSearchElement: true
      Ordereditem,
      
      @UI: { lineItem:       [ { position: 50,label: 'Delievery date', importance: #HIGH } ],
      identification: [ { position: 50, label: 'Delievery date' } ] }
      Deliverydate       as Deliverydate,
      
      @UI: { lineItem:       [ { position: 50,label: 'Creation date', importance: #HIGH } ],
             identification: [ { position: 50, label: 'Creation date' } ] }
      Creationdate       as Creationdate
}
