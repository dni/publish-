define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ListView'
  'cs!../view/DetailView'
  'cs!../view/TopView'
  'cs!../view/DashboardView'

], ( Vent, $, _, Backbone, Marionette, ListView, DetailView, TopView, DashboardView) ->

  class ReportController extends Backbone.Marionette.Controller

    show: (id) ->
      model = App.Reports.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: model[0]

    list : ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.Reports

    dashboard: ->
      Vent.trigger 'app:updateRegion', "contentRegion", new DashboardView