define [
    'cs!App'
    'cs!utils'
    'cs!Router'
    'marionette'
    'cs!modules/messages/model/Collection'
    'cs!./controller/Controller'
    "text!./configuration.json"
    'less!./style'
],
( App, Utils, Router, Marionette, Collection, Controller, Config ) ->

  App.Messages = new Collection
  App.Messages.fetch
    success:->

  Router.processAppRoutes new Controller,
    "messages": "list"

  Utils.addModule Config
