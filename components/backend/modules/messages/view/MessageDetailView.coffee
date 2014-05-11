define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/list-item.html'
], ($, _, Backbone, Template) ->

  class MessageDetailItemView extends Backbone.Marionette.ItemView
    tagName: 'li'
    initialize: ->
      @$el.addClass @model.get "type"
    template: Template

  class MessageDetailView extends Backbone.Marionette.CollectionView
    tagName: 'ul'
    className: 'messages'
    itemView: MessageDetailItemView
