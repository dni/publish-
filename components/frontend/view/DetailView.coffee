define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!templates/detail.html'
], ( $, _, Backbone, Marionette, Template) ->

  class DetailView extends Backbone.Marionette.ItemView
    template: Template
