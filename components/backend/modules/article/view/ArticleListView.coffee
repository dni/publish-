define [
  'marionette'
  'tpl!modules/article/templates/list-item.html'
], (Marionette, Template) ->

  class ArticleListItemView extends Marionette.ItemView
    template: Template
    initialize: ->
      @model.on "change", @render

  class ArticleListView extends Marionette.CollectionView
    itemView: ArticleListItemView
