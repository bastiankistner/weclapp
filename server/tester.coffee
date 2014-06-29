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
    "customerId": "1856",
    "deliveryAddress": {
      "addressLine1": "Jennnnnnnnnnnnnnnnnnnnnnnnnn Huaaaaaaaaaaaaaaaaaaaang",
      "addressLine2": "in der Luft",
      "city": "München",
      "countryCode": "DE",
      "postOfficeBoxCity": "",
      "postOfficeBoxNumber": "",
      "postOfficeBoxZipCode": "",
      "street1": "Balanstraße 69",
      "street2": "",
      "zipcode": "81541"
    },
    "invoiceAddress": {
      "addressLine1": "Jennnnnnn Zahlmal",
      "addressLine2": "a",
      "city": "München",
      "countryCode": "DE",
      "postOfficeBoxCity": "e",
      "postOfficeBoxNumber": "c",
      "postOfficeBoxZipCode": "d",
      "street1": "Residenzstraße 7",
      "street2": "b",
      "zipcode": "81000"
    },
    "orderItems": [
      {
        "articleId": "1606",
        "discountPercentage": "0",
        "manualUnitPrice": false,
        "quantity": "66"
      }
    ],
    "recordAddress": {
      "addressLine1": "Die adresse im original",
      "city": "die stadt im original",
      "countryCode": "DE",
      "street1": "straße orig",
      "zipcode": "28221"
    },
    "recordCurrencyName": "EUR",
    "salesOrderPaymentType": "STANDARD",
    "withShipment": true  
})
  .then (salesOrder) ->
    console.log salesOrder
  .fail (error) ->
    console.log error
  
