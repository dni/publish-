define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
  'cs!../model/Pages'
  'cs!../model/Page'
  'cs!./PageListView'
],
( $, _, Backbone, Template, Pages, Page, PageListView) ->

  class MagazineDetailView extends Backbone.Marionette.ItemView
    # Not required since 'div' is the default if no el or tagName specified
    template: Template

    initialize: ->
      @model.on "change", @render
