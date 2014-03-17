define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ListView'
  'cs!../view/DetailView'
  'cs!../model/StaticBlock'
  'cs!../view/TopView'
], ( Vent, $, _, Backbone, Marionette, ListView, DetailView, Model, TopView ) ->

  class StaticController extends Backbone.Marionette.Controller
#
    settings: ->
      App.Settings.where({name: "StaticModule"})[0]
#
    details: (id) ->
      model = App.StaticBlocks.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: model[0]

    add: ->
      view = new DetailView model: new Model
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.StaticBlocks