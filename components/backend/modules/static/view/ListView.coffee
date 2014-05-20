define [
  'marionette'
  'tpl!../templates/listItem.html'
], (Marionette, Template) ->

  class ListItemView extends Marionette.ItemView
    template: Template
    initialize: ->
      @model.on 'change', @render, @

  class ListView extends Marionette.CollectionView
    itemView: ListItemView
