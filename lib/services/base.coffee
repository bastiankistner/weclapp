_ = require 'lodash'
Q = require 'q'
logger = require('../utils/logger')(module)


module.exports = class BaseService
  
  @baseResourceEndpoint: ''
  
  constructor: (@_rest) -> @_setDefaults()
  
  ###
  * @private
  * Reset default endpoint and params used to build request endpoint
  ###
  _setDefaults: ->
    @_currentEndpoint = @constructor.baseResourceEndpoint


  # ====================================================================================================================
  # CONVENIENCE & QUERY METHODS
    
  findById: (id) ->
    @_currentEndpoint = "#{@constructor.baseResourceEndpoint}/id/#{id}"
    @_get "#{@_currentEndpoint}"
    
  findAll: () ->
    @_currentEndpoint = @constructor.baseResourceEndpoint
    @_get @_currentEndpoint



  # ====================================================================================================================
  # CUD Methods

  create: (data) ->
    unless data
      throw new Error "Body payload is required for creating a resource (endpoint: #{@_currentEndpoint})"
    @_currentEndpoint = @constructor.baseResourceEndpoint
    @_create @_currentEndpoint, data
  
  # TODO: align with _update comment
  update: (id, data) ->
    unless data
      throw new Error "Body payload is required for updating a resource (endpoint: #{@_currentEndpoint})"
    @_currentEndpoint = "#{@constructor.baseResourceEndpoint}/id/#{id}"
    @_update @_currentEndpoint, data
    
  delete: (id) ->
    @_currentEndpoint = "#{@constructor.baseResourceEndpoint}/id/#{id}"
    @_delete @_currentEndpoint

  
  # ====================================================================================================================
  # private wrapper METHODS

  _get: (endpoint) ->
    @_setDefaults()
    originalRequest =
      endpoint: endpoint
    deferred = Q.defer()
    @_rest.get endpoint, () =>
      @_wrapResponse.apply(@, [deferred, originalRequest].concat(_.toArray(arguments)))
    return deferred.promise

  _create: (endpoint, data) ->
    @_setDefaults()
    originalRequest =
      endpoint: endpoint 
      payload: data
    deferred = Q.defer()
    @_rest.post endpoint, originalRequest.payload, () =>
      @_wrapResponse.apply(@, [deferred, originalRequest].concat(_.toArray(arguments)))
    return deferred.promise
    
  ###
   * Update is not yet possible. Furthermore, we need to know if we can update by id through the resource or if 
   * we can simply pass the object that we want to update. The latter one would imply that the id is included in the
   * body payload.
  ###
  _update: (endpoint, data) ->
    @_setDefaults()
    originalRequest =
      endpoint: endpoint
      payload: data
    deferred = Q.defer()
    @_rest.put endpoint, originalRequest.payload, () =>
      @_wrapResponse.apply(@, [deferred, originalRequest].concat(_.toArray(arguments)))
    return deferred.promise

  # TODO: verify if delete works via id or via objects that we could pass
  _delete: (id) ->
    @_setDefaults()
    originalRequest =
      endpoint: endpoint
    deferred = Q.defer()
    @_rest.delete endpoint, () =>
      @_wrapResponse.apply(@, [deferred, originalRequest].concat(_.toArray(arguments)))
    return deferred.promise
    
    
    
  _wrapResponse: (deferred, originalRequest, error, response, body) ->
    if error
      errorResp =
        statusCode: 500
        message: error
        originalRequest: originalRequest
      errorResp.body = body if body
      deferred.reject errorResp
    else
      if 200 <= response.statusCode < 300
        deferred.resolve body
      else if response.statusCode is 404
        endpoint = response.request.uri.path
        deferred.reject
          statusCode: 404
          message: "Endpoint '#{endpoint}' not found."
          originalRequest: originalRequest
      else
        deferred.reject _.extend body, {originalRequest: originalRequest}
