define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!./../templates/detail.html'
  'cs!./../view/Viewhelpers'
  'fancybox'
], ( $, _, Backbone, Marionette, Template, Viewhelpers, fancybox) ->

  class DetailView extends Backbone.Marionette.ItemView
    template: Template
    templateHelpers: Viewhelpers
    className: "details"
    initialize:->
      @.on "render", ->
        $('.thumbnail').fancybox()
