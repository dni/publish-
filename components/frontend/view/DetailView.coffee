define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!templates/detail.html'
  'cs!view/Viewhelpers'
], ( $, _, Backbone, Marionette, Template, Viewhelpers) ->

  class DetailView extends Backbone.Marionette.ItemView
    template: Template
    templateHelpers: Viewhelpers
