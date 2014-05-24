define [
  'cs!App'
  'cs!utils'
  'i18n!modules/messages/nls/language.js'
  'marionette'
  'cs!../view/MessageListView'
  'cs!../view/MessageDetailView'
  'cs!utilities/views/TopView'

], ( App, Utils, i18n, Marionette, ListView, DetailView, TopView) ->

  class MessageController extends Backbone.Marionette.Controller

    list : ->
      App.listTopRegion.show new TopView navigation:i18n.navigation
      App.listRegion.show new ListView
      App.contentRegion.show new DetailView collection: App.Messages
