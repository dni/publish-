define [
  'cs!App'
  'cs!utils'
  'marionette'
  'cs!../view/MessageListView'
  'cs!../view/MessageDetailView'
  'cs!../view/TopView'

], ( App, Utils, Marionette, ListView, DetailView, TopView) ->

  class MessageController extends Backbone.Marionette.Controller

    list : ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new ListView
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', new DetailView collection: App.Messages
