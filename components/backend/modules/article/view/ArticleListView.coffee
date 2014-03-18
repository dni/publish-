define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/listItem.html'
  'tpl!../templates/list.html'
  'tpl!../templates/filter.html'
], ($, _, Backbone, Template, ListTemplate, FilterTemplate) ->

  class ArticleListItemView extends Backbone.Marionette.ItemView
    template: Template
    initialize: ->
      @model.on "change", @render

  class ArticleListView extends Backbone.Marionette.CollectionView
    itemView: ArticleListItemView
