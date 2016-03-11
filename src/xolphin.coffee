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

  scheduleValidationCall: (id, dateTime, callback) =>
    @client.post "requests/#{id}/schedule-validation-call", {
      date: dateTime.toISOString().split('T')[0],
      time: dateTime.toISOString().split('T')[1].split('.')[0],
    }, callback

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
  constructor: (@username, @password) ->
    #process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';
    @r = r.defaults
      #proxy: 'http://127.0.0.1:8888/'
      headers:
        'Accept': 'application/json'

    @baseUrl = "https://#{@username}:#{@password}@api.xolphin.com/v1/"

    @support = new Support @
    @request = new Request @
    @certificate = new Certificate @

  get: (method, data = {}, callback) =>
    @r.get
      url: "#{@baseUrl}#{method}?#{querystring.stringify(data)}"
    , (e, r, b) =>
        if e?
          callback true, e, b if typeof(callback) == 'function'
        else
          if 200 <= r.statusCode < 300
            b = JSON.parse(b) if typeof(b) == 'string'

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
      if e?
        callback true, e, b if typeof(callback) == 'function'
      else
        if 200 <= r.statusCode < 300
          b = JSON.parse(b) if typeof(b) == 'string'

          if not b.hasOwnProperty('errors')
            callback false, b, b if typeof(callback) == 'function'
          else
            callback true, b.message, b if typeof(callback) == 'function'
        else
          callback true, b, b if typeof(callback) == 'function'

module.exports =
  Client: Client