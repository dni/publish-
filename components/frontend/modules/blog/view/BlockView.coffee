define [
  'jquery',
  'marionette',
], ($, Marionette) ->
  class ItemView extends Marionette.ItemView
    render: ->
      console.log 'Lol'
      key = @model.get "key"
      el = $('[block="'+key+'"]')
      el.attr "id", key
      el.removeAttr('block')
      console.log el
      el.html @model.get "data"

  class BlockView extends Marionette.CollectionView
    itemView: ItemView

