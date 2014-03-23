define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/list-item.html'
],
($, _, Backbone, ItemTemplate) ->

  class ItemView extends Backbone.Marionette.ItemView
    template: ItemTemplate
    initialize:->
      @model.on "change", @render

  class MagazineListView extends Backbone.Marionette.CollectionView
    itemView: ItemView
