@EndUserText.label: 'Consumtion View'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@UI: { headerInfo: { typeName: 'Order your Gadgets',
                     typeNamePlural: 'Order your Gadgets',
                     title: { type: #STANDARD, label: 'Order your Gadgets', value: 'order_id' } },

       presentationVariant: [{ sortOrder: [{ by: 'Creationdate',
                                             direction: #DESC }] }] }

define root view entity ZAD_C_online_shop
  provider contract transactional_query
  as projection on ZAD_I_ONLINE_SHOP
{
      @UI.facet: [          { id:                  'Orders',
                                   purpose:         #STANDARD,
                                   type:            #IDENTIFICATION_REFERENCE,
                                   label:           'Order',
                                   position:        10 }      ]
  key Order_Uuid,
      @UI: { lineItem:       [ { position: 10,label: 'Order ID', importance: #HIGH } ],
               identification: [ { position: 10, label: 'Order Id' } ] }
      @Search.defaultSearchElement: true
      //@UI.hidden: true
      Order_Id,
      @UI: { lineItem:       [ { position: 20,label: 'Gadget Name', importance: #HIGH } ],
              identification: [ { position: 20, label: 'Ordered item' } ] }
      @Search.defaultSearchElement: true
      Ordereditem,

      @UI: { lineItem:       [ { position: 50,label: 'Delivery date', importance: #HIGH } ],
      identification: [ { position: 50, label: 'Delivery date' } ] }
      //@UI.hidden: true
      Deliverydate               as Deliverydate,

      @UI: { lineItem:       [ { position: 50,label: 'Creation Date', importance: #HIGH } ],
             identification: [ { position: 50, label: 'Creation Date' } ] }
      //@UI.hidden: true
      Creationdate               as Creationdate,

      @UI: { lineItem:       [ { position: 60,label: 'Purchase Requisition No', importance: #HIGH }  ],
      identification: [ { position: 60, label: 'Purchase Requistion No' } ] }
      _purchase_req.Purchasereqn as PurchaseRequistionNumber
}
