define [
  'jquery',
  'lodash',
  'backbone',
  'marionette',
  'tpl!templates/listItem.html'
  'cs!view/Viewhelpers'
], ($, _, Backbone, Marionette, Template, Viewhelpers) ->
  class ListItemView extends Backbone.Marionette.ItemView
    template: Template
    templateHelpers: Viewhelpers
    className: 'list-item'
    tagName: 'article'

  class ListView extends Backbone.Marionette.CollectionView
    itemView: ListItemView
    className: 'list'


# http://lostechies.com/derickbailey/2012/04/26/view-helpers-for-underscore-templates/