define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/listItem.html'
], ($, _, Backbone, Template) ->

  class ArticleListItemView extends Backbone.Marionette.ItemView
    template: Template
    initialize: ->
      @model.on "change", @render

  class ArticleListView extends Backbone.Marionette.CollectionView
    itemView: ArticleListItemView
