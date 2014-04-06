define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/StaticBlock'
    'cs!./model/StaticBlocks'
    'cs!./controller/StaticBlockController'
    'text!./configuration.json'
], ( Marionette, Vent, StaticBlock, StaticBlocks, Controller, Config ) ->

  Vent.on "app:ready", ()->
    Vent.trigger "app:addModule", JSON.parse Config
    App.StaticBlocks = new StaticBlocks
    App.StaticBlocks.fetch
      success:->

    App.Router.processAppRoutes new Controller,
      "staticBlocks": "list"
      "staticBlock/:id": "details"
      "newStaticBlock": "add"
    Vent.trigger "staticBlocks:ready"
