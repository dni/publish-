define [
    'cs!App'
    'cs!Router'
    'cs!utils'
    'cs!lib/controller/Controller'
], ( App, Router, Utils, Controller) ->
  class Module
    constructor: (args)->
      @[key] = arg for key, arg of args

    init:->
      unless @Config? then return c.l "no module Config"
      unless @i18n? then return c.l "no module i18n"
      @Config = JSON.parse @Config
      config = @Config
      unless @Controller?
        @Controller = new Controller
          i18n: @i18n
          Config: @Config

      # collection
      if @Config.collectionName
        App[@Config.collectionName] = new @Controller.Collection
        App[@Config.collectionName].url = @Config.url
        App[@Config.collectionName].fetch
          success:->
            Utils.Vent.trigger config.name+":collection:ready"

      # Routes from Controller
      routes = @Controller.routes || {}

      # Standard Routes
      routes[@Config.name] = "list"
      routes[@Config.modelName+'/:id'] = "details"
      routes['new'+@Config.modelName] = "add"
      Router.processAppRoutes @Controller, routes
      # add module (settings/navigation)
      Utils.addModule @Config, @i18n


