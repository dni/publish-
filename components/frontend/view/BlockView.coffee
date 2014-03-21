define [
  'jquery',
  'lodash',
  'backbone',
  'marionette',
  'tpl!templates/block.html'
], ($, _, Backbone, Marionette, Template) ->
  class ItemView extends Backbone.Marionette.ItemView
    template: Template
    render: ->
      key = @model.get "key"
      el = $('[block="'+key+'"]')
      el.attr "id", key
      el.removeAttr('block')
      el.html @model.get "data"

  class BlockView extends Backbone.Marionette.CollectionView
    itemView: ItemView

