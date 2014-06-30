define [
    'cs!App'
    'cs!Router'
    'cs!utils'
], ( App, Router, Utils ) ->

  class Module
    init:->

      App[@Config.collectionName] = new @Collection
      App[@Config.collectionName].fetch
        success:-> Utils.Vent.trigger @Config.moduleName+":collection:ready"

      Router.processAppRoutes new @Controller,
        @Config.moduleName: "show"
        @Config.modelName: "details"
        "new"+@Config.modelName: "add"

      Utils.addModule @Config, @i18n
