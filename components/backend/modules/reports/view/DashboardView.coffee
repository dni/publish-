define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/dashboard.html'
  'd3'
], ($, _, Backbone, Template, d3) ->
  window.d3 = d3
  class DashboardView extends Backbone.Marionette.ItemView
    template: Template