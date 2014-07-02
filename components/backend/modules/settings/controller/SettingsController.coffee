define [
  'cs!App'
  'cs!Settings'
  'cs!utils'
  'i18n!modules/settings/nls/language.js'
  'jquery'
  'marionette'
  'cs!../view/SettingsListView'
  'cs!../view/SettingsLayout'
  'cs!utilities/views/TopView'
  'cs!modules/files/model/Files'
],
( App, Settings, Utils, i18n, $, Marionette, ListView, Layout, TopView, Files ) ->

  class SettingsController extends Marionette.Controller

    details: (moduleName) ->
      model = App.Settings.findWhere name: moduleName
      Utils.Vent.trigger 'app:updateRegion', "contentRegion", new Layout
        model: model
        files: new Files App.Files.where relation: "setting:"+model.get "_id"

    list: ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
        navigation: i18n.headline
        newModel: 'settings/clearCache'
        icon: 'refresh'

      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.Settings

    clearCache: ->
      $.get "/clearCache", ->
        Utils.Log i18n.clearCache, 'info'
