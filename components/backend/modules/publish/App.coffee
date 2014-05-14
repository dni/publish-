define [
  'marionette'
  'cs!utils'
  'text!modules/publish/configuration.json'
  'cs!./Router'
],
( Marionette, Utilities, Config, Router)->
  App = new Marionette.Application()
  App.Router = new Router
  App.addInitializer ->
    Utilities.Vent.trigger "app:addModule", JSON.parse Config

  return App


