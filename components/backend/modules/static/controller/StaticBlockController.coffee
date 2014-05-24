define [
  'cs!App'
  'cs!utils'
  'i18n!modules/static/nls/language.js'
  'marionette'
  'cs!../view/ListView'
  'cs!../view/DetailView'
  'cs!../model/StaticBlock'
  'cs!utilities/views/EmptyView'
  'cs!utilities/views/TopView'
], ( App, Utils, i18n, Marionette, ListView, DetailView, Model, EmptyView, TopView ) ->

  class StaticController extends Marionette.Controller

    details: (id) ->
      model = App.StaticBlocks.findWhere _id: id
      if model
        Utils.Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: model
      else
        Utils.Vent.trigger 'app:updateRegion', "contentRegion", new EmptyView message: i18n.emptyMessage

    add: ->
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', new DetailView model: new Model

    list: ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView navigation: i18n.navigation, newModel: 'newStaticBlock'
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.StaticBlocks