r = require 'request'
async = require 'async'
querystring = require 'querystring'
requests = require './requests.js'

class Request
  constructor: (@client) ->

  all: (callback) =>
    requests = []
    @client.get "requests", {page: 1}, (err, result) =>
      requests = result._embedded.requests
      page = result.page
      pages = result.pages
      async.until () ->
        pages == page
      , (cb) =>
        @client.get "requests", {page: page + 1}, (err, result) ->
          requests = requests.concat result._embedded.requests
          page = result.page
          pages = result.pages
          cb(err)
        return
      , (err) ->
        callback err, requests
        return

  create: (product, years, csr, dcvType) =>
    new requests.CreateCertificateRequest product, years, csr, dcvType

  send: (request, callback) =>
    @client.post "requests", request.toArray(), callback

  createEE: () ->
    new requests.CreateEERequest() 

  sendEE: (request, callback) ->
    @client.post "requests/ee", request.toArray(), callback

  get: (id, callback) =>
    @client.get "requests/#{id}", {}, (err, result) =>
      callback err, result

  uploadDocument: (id, document, description, callback) =>
    @client.post "requests/#{id}/upload-document", {
      document: document,
      description: description
    }, callback

  retryDCV: (id, domain, dcvType, email = '', callback) =>
    @client.post "requests/#{id}/retry-dcv", {
      domain: domain,
      dcvType: dcvType,
      email: email
    }, callback

  scheduleValidationCall: (id, dateTime, timezone = "Europe/Amsterdam", callback, phoneNumber, extensionNumber, email, comments, action = "ScheduledCallback", language = "en_us") =>
    request = {
      date: dateTime.toISOString().split('T')[0],
      time: dateTime.toISOString().split('T')[1].split('.')[0].substring(0,5),
      timezone: timezone
    }
    request['phoneNumber'] = phoneNumber if phoneNumber != null
    request['extensionNumber'] = extensionNumber if extensionNumber != null
    request['email'] = email if email != null
    request['comments'] = comments if comments != null
    request['action'] = action if action != 'ScheduledCallback'
    request['language'] = language if language != 'en_us'

    @client.post "requests/#{id}/schedule-validation-call", request, callback

  getNotes: (id, callback) =>
    @client.get "requests/#{id}/notes", {}, (err, result) =>
      callback err, result._embedded.notes

  sendNote: (id, note, callback) =>
    @client.post "requests/#{id}/notes", {
      message: note
    }, (err, result) =>
      callback err, result

  sendComodoSAEmail: (id, to, lang, callback) =>
    @client.post "requests/#{id}/sa", {
      sa_email: to,
      language: lang
    }, (err, result) =>
      callback err, result

class Certificate
  constructor: (@client) ->

  all: (callback) =>
    certificates = []
    @client.get "certificates", {page: 1}, (err, result) =>
      certificates = result._embedded.certificates
      page = result.page
      pages = result.pages
      async.until () ->
        pages == page
      , (cb) =>
        @client.get "certificates", {page: page + 1}, (err, result) ->
          certificates = certificates.concat result._embedded.certificates
          page = result.page
          pages = result.pages
          cb(err)
        return
      , (err) ->
        callback err, certificates
        return

  get: (id, callback) =>
    @client.get "certificates/#{id}", {}, (err, result) =>
      callback err, result

  download: (id, format, callback) =>
    @client.download "certificates/#{id}/download", {
      format: format,
    }, callback

  reissue: (id, request, callback) =>
    @client.post "certificates/#{id}/reissue", request.toArray(), callback

  renew: (id, request, callback) =>
    @client.post "certificates/#{id}/renew", request.toArray(), callback

  cancel: (id, reason, revoke, callback) =>
    @client.post "certificates/#{id}/cancel", {
      reason: reason,
      revoke: revoke
    }, callback

class Support
  constructor: (@client) ->

  approverEmailAddresses: (domain, callback) =>
    @client.get "approver-email-addresses", {domain: domain}, callback

  decodeCSR: (csr, callback) =>
    @client.post "decode-csr", {csr: csr}, callback

  products: (callback) =>
    products = []
    @client.get "products", {page: 1}, (err, result) =>
      products = result._embedded.products
      page = result.page
      pages = result.pages
      async.until () ->
        pages == page
      , (cb) =>
        @client.get "products", {page: page + 1}, (err, result) ->
          products = products.concat result._embedded.products
          page = result.page
          pages = result.pages
          cb(err)
        return
      , (err) ->
        callback err, products
        return

  product: (id, callback) =>
    @client.get "products/#{id}", {}, (err, result) =>
      callback err, result

class Client
  constructor: (@username, @password, @test) ->
    #process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';
    @r = r.defaults
      #proxy: 'http://127.0.0.1:8888/'
      headers:
        'Accept': 'application/json'
        'User-Agent': 'xolphin-api-js/1.1'
    
    if @test
      @env = "@xolphin-public-api.loc/v1/" 
    else 
      @env = "@api.xolphin.com/v1/"

    @baseUrl = "https://#{@username}:#{@password}#{@env}"

    @support = new Support @
    @request = new Request @
    @certificate = new Certificate @

  get: (method, data = {}, callback) =>
    @r.get
      url: "#{@baseUrl}#{method}?#{querystring.stringify(data)}"
    , (e, r, b) =>
        b = @_toObject b
        if e?
          callback true, e, b if typeof(callback) == 'function'
        else
          if 200 <= r.statusCode < 300
            if not b.hasOwnProperty('message') and not b.hasOwnProperty('errors')
              callback false, b, b if typeof(callback) == 'function'
            else
              callback true, b.message, b if typeof(callback) == 'function'
          else
            callback true, b, b if typeof(callback) == 'function'

  download: (method, data = {}, callback) =>
    @r.get
      url: "#{@baseUrl}#{method}?#{querystring.stringify(data)}"
    , (e, r, b) =>
        b = @_toObject b
        if e?
          callback true, e, b if typeof(callback) == 'function'
        else
          if 200 <= r.statusCode < 300
            callback false, b, b if typeof(callback) == 'function'
          else
            callback true, b, b if typeof(callback) == 'function'

  post: (method, data = {}, callback) =>
    @r.post
      url: "#{@baseUrl}#{method}",
      formData: data
    , (e, r, b) =>
      b = @_toObject b
      if e?
        callback true, e, b if typeof(callback) == 'function'
      else
        if 200 <= r.statusCode < 300
          if not b.hasOwnProperty('errors')
            callback false, b, b if typeof(callback) == 'function'
          else
            callback true, b.message, b if typeof(callback) == 'function'
        else
          callback true, b, b if typeof(callback) == 'function'
  _toObject: (json) =>
    try
      JSON.parse(json)
    catch
      return json
    return JSON.parse(json)
    

module.exports =
  Client: Client
