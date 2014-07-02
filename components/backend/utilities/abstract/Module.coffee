define [
    'cs!App'
    'cs!Router'
    'cs!utils'
], ( App, Router, Utils ) ->
  class Module
    constructor: (@Controller)->
      # @[key] = arg for key, arg in args

    init:->
      config = @Controller.Config

      # collection
      if config.collectionName
        App[config.collectionName] = new @Controller.Collection
        App[config.collectionName].fetch
          success:->
            Utils.Vent.trigger config.name+":collection:ready"

      # Routes from Controller
      routes = @Controller.routes || {}

      # Standard Routes
      routes[config.name] = "list"
      routes[config.modelName+'/:id'] = "details"
      routes['new'+config.modelName] = "add"
      Router.processAppRoutes @Controller, routes

      # add module (settings/navigation)
      Utils.addModule config, @Controller.i18n

