define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/MessageListView'
  'cs!../view/MessageDetailView'
  'cs!../view/TopView'

], ( Vent, $, _, Backbone, Marionette, ListView, DetailView, TopView) ->

  class MessageController extends Backbone.Marionette.Controller

    list : ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView
      Vent.trigger 'app:updateRegion', 'contentRegion', new DetailView collection: App.Messages
