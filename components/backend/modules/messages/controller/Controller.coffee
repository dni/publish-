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
      App.listTopRegion.show new TopView
      App.listRegion.show new ListView
      App.contentRegion.show new DetailView collection: App.Messages
