request = require 'request'
Q = require 'q'
_ = require 'lodash'
logger = require('./logger')(module)

module.exports = class RestClient

  constructor: (options = {}) ->
    logger.info 'Initializing RestClient:', options
    
    config = options.config
    
    throw new Error('missing config') unless options
    throw new Error('Missing api key') unless options.apikey
    throw new Error('Missing subdomain') unless options.subdomain

    userAgent = if _.isUndefined(options.userAgent) then 'weclapp-client' else options.userAgent
      
    @_options =
      config: config
      host: options.host or "#{options.subdomain}.weclapp.com"
      accessToken: options.apikey or undefined
      timeout: options.timeout or 20000
      apiUri: options.apiUri or '/webapp/api/v1'
      
    @_options.headers = 
      "User-Agent": userAgent
      "Content-Type": "application/json"
      "AuthenticationToken": @_options.accessToken
    @_options.uri = "https://#{@_options.host}#{@_options.apiUri}"
      
    logger.info 'New RestClient created', @_options

  
    
  # ====================================================================================================================
  # METHOD IMPLEMENTATION  

  ###*
   * Send a HTTP GET request to an API endpoint
   * @param {String} resource The API resource endpoint, with query string parameters.
   * @param {Function} callback A function fulfilled with `error, response, body` arguments.
  ###
  get: (resource, callback) ->
    params = 
      method: "GET"
      resource: resource 
    logger.debug 'GET request: ', _.extend({}, params)
    @_preRequest params, callback

  ###*
   * Send a HTTP POST request to an API endpoint
   * @param {String} resource The API resource endpoint, with query string parameters.
   * @param {Object} payload A JSON object used as `body` payload
   * @param {Function} callback A function fulfilled with `error, response, body` arguments.
  ###
  post: (resource, payload, callback) ->
    params =
      method: "POST"
      resource: resource
      body: payload
    logger.debug 'POST request: ', _.extend({}, params)
    @_preRequest(params, callback)

  ###*
   * Send a HTTP DELETE request to an API endpoint
   * @param {String} resource The API resource endpoint, with query string parameters.
   * @param {Function} callback A function fulfilled with `error, response, body` arguments.
  ###
  delete: (resource, callback) ->
    params = 
      method: "DELETE"
      resource: resource
    logger.debug 'DELETE request: ', _.extend({}, params)
    @_preRequest(params, callback)

  ###*
   * Send a HTTP PUT request to an API endpoint
   * @param {String} resource The API resource endpoint, with query string parameters.
   * @param {Object} payload A JSON object used as `body` payload to update the resource
   * @param {Function} callback A function fulfilled with `error, response, body` arguments.
  ###
  put: (resource, payload, callback) ->
    params =
      method: "PUT"
      resource: resource
      body: payload
    logger.debug 'PUT request: ', _.extend({}, params)
    @_preRequest(params, callback)

    
  # ====================================================================================================================
  # REQUEST IMPLEMENTATION  
   
  _preRequest: (params, callback) ->
    request_options = 
      uri: "#{@_options.uri}#{params.resource}"
      json: true
      method: params.method
      headers: @_options.headers
      timout: @_options.timeout
    if params.body 
      request_options.body = params.body     
    @_doRequest(request_options, callback)
        
  _doRequest: (options, callback) -> 
    request options, (error, response, body) =>
      logger.error error if error
      logger.debug "RestClient response", {request: response?.request, response: response}
      callback(error, response, body)
      
     
    