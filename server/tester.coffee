weclapp = require("../index")


client = new weclapp(
  apikey: "9d7567fe-e024-4ecd-9be1-ec7f7234302b"
  subdomain: "devsonsana"
)
###
promise = client.getCustomer()

promise
  .then (value) ->
    console.log value
  .fail (error) ->
    console.log error

###
  
###
client.customer.findAll()
  .then (value) ->
    console.log value
  .fail (error) ->
    console.log error
###

###
client.customer.findById(1715)
  .then (customer) ->
    console.log customer
  .fail (error) ->
    console.log error
###

###
client.salesOrder.findById(1715)
.then (customer) ->
  console.log customer
.fail (error) ->
  console.log error
###

###
client.customer.create({
    "addresses": [
      {
        "city": "München",
        "countryCode": "DE",
        "deliveryAddress": true,
        "primeAddress": true,
        "street1": "Lindastraße 33",
        "zipcode": "80011"
      }
    ],
    "contacts": [],
    "currencyName": "EUR",
    "firstName": "Linda",
    "lastName": "Wiadinda",
    "partyType": "PERSON",
    "salutation": "MRS" # possible values: MR || MRS
})
  .then (customer) ->
    console.log customer
  .fail (error) ->
    console.log error
###
  


client.salesOrder.create(
  {
    "customerId": "1348"
    "commercialLanguage": "German"
    "deliveryAddress": {
      "addressLine1": "Florian Kistner"
      "addressLine2": "addresse2"
      "city": "Neumarkt"
      "countryCode": "DE"
      "postOfficeBoxCity": ""
      "postOfficeBoxNumber": ""
      "postOfficeBoxZipCode": ""
      "street1": "Lärchenweg 6a"
      "street2": ""
      "zipcode": "92318"
    }
    "invoiceAddress": {
      "addressLine1": "Netlight GmbH"
      "addressLine2": "a"
      "city": "München"
      "countryCode": "DE"
      "postOfficeBoxCity": "e"
      "postOfficeBoxNumber": "c"
      "postOfficeBoxZipCode": "d"
      "street1": "Residenzstraße 7"
      "street2": "strase 2"
      "zipcode": "81333"
    }
    "recordAddress": {
      "addressLine1": "Die adresse im original"
      "city": "die stadt im original"
      "countryCode": "DE"
      "street1": "straße orig"
      "zipcode": "28221"
    }
    "orderItems": [
      {
        "articleId": "1606" #TODO: create a map with articles | ids
        "discountPercentage": "0"
        "manualUnitPrice": false
        "quantity": "8"
      }
      {
        "articleId": "1606" #TODO: create a map with articles | ids
        "discountPercentage": "0"
        "manualUnitPrice": false
        "quantity": "3"
      }
    ]
    "paymentMethodId": "1933" #TODO: create a map with methods | ids
    "shipmentMethodId": "1148" #TODO: create a map with methods | ids
    "withShipment": true
    "recordCurrencyName": "EUR"
    "salesOrderPaymentType": "STANDARD"    
})
  .then (salesOrder) ->
    console.log salesOrder
  .fail (error) ->
    console.log error
  
