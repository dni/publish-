define [
  'marionette'
  'tpl!../templates/list-item.html'
], (Marionette, Template) ->

  class MessageDetailItemView extends Marionette.ItemView
    tagName: 'li'
    initialize: ->
      @$el.addClass @model.get "type"
    template: Template

  class MessageDetailView extends Backbone.Marionette.CollectionView
    tagName: 'ul'
    className: 'messages'
    itemView: MessageDetailItemView
