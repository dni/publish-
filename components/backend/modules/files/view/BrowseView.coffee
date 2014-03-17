define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/browseItem.html'
], ($, _, Backbone, Template) ->

  class ItemView extends Backbone.Marionette.ItemView
    template: Template

  class BrowseView extends Backbone.Marionette.CollectionView
    itemView: ItemView
