define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/StaticBlocks'
    'cs!./controller/StaticBlockController'
    'text!./configuration.json'
], ( Marionette, Vent, StaticBlocks, Controller, Config ) ->

  Vent.on "app:ready", ()->
    Vent.trigger "app:addModule", JSON.parse Config
    App.StaticBlocks = new StaticBlocks
    App.StaticBlocks.fetch
      success:->
        head = App.StaticBlocks.where key: "head"
        if !head[0]?
          head = "<title> Undefined - Title </tile>"

        c.l "head", head

    App.Router.processAppRoutes new Controller,
      "staticBlocks": "list"
      "staticBlock/:id": "details"
      "newStaticBlock": "add"
    Vent.trigger "staticBlocks:ready"
