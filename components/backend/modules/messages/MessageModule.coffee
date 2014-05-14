define [
    'cs!utils'
    'marionette'
    'cs!modules/messages/model/Collection'
    # 'cs!./controller/Controller'
    "text!./configuration.json"
    'less!./style'
],
( Utils, Marionette, Collection, Controller, Config ) ->
  c.l "message"
  Utils.Vent.on "app:ready", ->

    Utils.Vent.trigger "app:addModule", JSON.parse Config

    App.Messages = new Collection
    App.Messages.fetch
      success:->

    App.Router.processAppRoutes new Controller,
      "messages": "list"

  return