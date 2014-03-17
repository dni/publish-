define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/listItem.html'
], ($, _, Backbone, Template) ->

  class ListItemView extends Backbone.Marionette.ItemView
    template: Template
    initialize: ->
      @model.on 'change', @render, @

  class ListView extends Backbone.Marionette.CollectionView
    itemView: ListItemView
