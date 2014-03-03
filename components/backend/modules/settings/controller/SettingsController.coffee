define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/SettingsListView'
  'cs!../view/SettingsDetailView'
  'cs!../view/SettingsListTopView' 
],
( Vent, $, _, Backbone, Marionette, ListView, DetailView, ListTopView ) ->

  class SettingsController extends Backbone.Marionette.Controller

    details: (id) ->
      model = App.Settings.where name: id
      console.log model
      Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: model[0]
      # App.uploadHandler '#images', article

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new ListTopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.Settings
      

    clearCache: ->
      $.get "/clearCache", ->
        console.log "cache cleared"
