define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/browseItem.html'
], ($, _, Backbone, Template) ->

  class ItemView extends Backbone.Marionette.ItemView
    template: Template
    events:
      "click input": 'toggleSelect'

    toggleSelect: -> @model.set "selected", !@model.get "selected"


  class BrowseView extends Backbone.Marionette.CollectionView
    itemView: ItemView
