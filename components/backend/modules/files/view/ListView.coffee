define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/listItem.html'
  'tpl!../templates/list.html'
  'tpl!../templates/filter.html'
], ($, _, Backbone, Template, ListTemplate, FilterTemplate) ->

  class ItemView extends Backbone.Marionette.ItemView
    template: Template

  class ListView extends Backbone.Marionette.CollectionView
    itemView: ItemView
