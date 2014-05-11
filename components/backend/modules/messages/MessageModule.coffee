define [
    'cs!../../utilities/Vent'
    'marionette'
    'cs!./model/Collection'
    'cs!./controller/Controller'
    "text!./configuration.json"
    'less!./style'
],
( Vent, Marionette, Collection, Controller, Config ) ->

  Vent.on "app:ready", ->

    Vent.trigger "app:addModule", JSON.parse Config

    App.Messages = new Collection
    App.Messages.fetch
      success:->

    App.Router.processAppRoutes new Controller,
      "messages": "list"
