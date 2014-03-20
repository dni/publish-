define ['jquery', 'lodash', 'backbone', 'marionette', 'tpl!templates/listItem.html'],
($, _, Backbone, Marionette, Template) ->

  class ListItemView extends Backbone.Marionette.ItemView
    template: Template
    className: 'list-item'

  class ListView extends Backbone.Marionette.CollectionView
    itemView: ListItemView
    className: 'list'
