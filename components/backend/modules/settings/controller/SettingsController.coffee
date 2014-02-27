define [
  'cs!../../../Command'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/SettingsListView'
  'cs!../view/SettingsDetailView'
  'cs!../view/SettingsListTopView' 
],
( Command, $, _, Backbone, Marionette, ListView, DetailView, ListTopView ) ->

  class SettingsController extends Backbone.Marionette.Controller

    details: (id) ->
      model = App.Settings.where _id: id
      Command.execute 'app:updateRegion', "contentRegion", new DetailView model: model[0]
      # App.uploadHandler '#images', article


    list: ->
      Command.execute 'app:updateRegion', 'listTopRegion', new ListTopView
      Command.execute 'app:updateRegion', 'listRegion', new ListView collection: App.Settings