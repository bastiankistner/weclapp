_ = require 'lodash'
RestClient = require './utils/restclient'
logger = require('./utils/logger')(module)


CustomerService = require './services/customer'
SalesOrderService = require './services/salesOrder'
ArticleService = require './services/article'

###
  weclapp client
  based on https://github.com/sphereio/sphere-node-client/tree/master/src/coffee
###
module.exports = class WeclappClient
  
  constructor: (options = {}) ->
    @_rest = new RestClient(options)
    
    
    @customer = new CustomerService @_rest
    @salesOrder = new SalesOrderService @_rest
    @article = new ArticleService @_rest
    
    
  ###
  getCustomer: () ->
    deferred = Q.defer()
    
    @r({
        url: 'https://devsonsana.weclapp.com/webapp/api/v1/customer'
        method: 'GET'
      }, (error, response, body) ->
      if error then deferred.reject error
      else deferred.resolve body
    )
    
    return deferred.promise
  ###
