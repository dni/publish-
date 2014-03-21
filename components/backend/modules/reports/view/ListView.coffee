define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/listItem.html'
], ($, _, Backbone, Template) ->

  class ItemView extends Backbone.Marionette.ItemView
    template: Template

  class ListView extends Backbone.Marionette.CollectionView
    itemView: ItemView
