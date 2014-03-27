define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/SettingsListView'
  'cs!../view/SettingsLayout'
  'cs!../view/SettingsListTopView'
  'cs!../../files/model/Files'
],
( Vent, $, _, Backbone, Marionette, ListView, Layout, ListTopView, Files ) ->

  class SettingsController extends Backbone.Marionette.Controller

    details: (id) ->
      model = App.Settings.where name: id
      Vent.trigger 'app:updateRegion', "contentRegion", new Layout
        model: model[0]
        files: new Files App.Files.where relation: "setting:"+id

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new ListTopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.Settings


    clearCache: ->
      $.get "/clearCache", ->
        console.log "cache cleared"
        window.location.reload()
