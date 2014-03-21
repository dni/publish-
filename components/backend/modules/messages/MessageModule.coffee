define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/Collection'
    'cs!./controller/Controller'
    "text!./configuration.json"
],
( Marionette, Vent, Collection, Controller, Config ) ->


  Vent.on "app:ready", ()->

    Vent.trigger "app:addModule", JSON.parse Config
    App.Messages = new Collection
    App.Messages.fetch
      success:->


    App.Router.processAppRoutes new Controller,
      "messages": "list"
      "message/:id": "show"

    Vent.trigger "messages:ready"

