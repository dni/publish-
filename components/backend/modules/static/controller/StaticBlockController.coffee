define [
  'cs!App'
  'cs!utils'
  'marionette'
  'cs!../view/ListView'
  'cs!../view/DetailView'
  'cs!../model/StaticBlock'
  'cs!../view/TopView'
], ( App, Utils, Marionette, ListView, DetailView, Model, TopView ) ->

  class StaticController extends Marionette.Controller
    settings: ->
      App.Settings.where({name: "StaticModule"})[0]

    details: (id) ->
      model = App.StaticBlocks.where _id: id
      Utils.Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: model[0]

    add: ->
      view = new DetailView model: new Model
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', view

    list: ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.StaticBlocks