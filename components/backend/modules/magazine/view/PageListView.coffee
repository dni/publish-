define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'text!../templates/pageListItem.html'
], ($, _, Backbone, Marionette, Template) ->

  class PageListItemView extends Backbone.Marionette.ItemView
    template: Template
    events:
      "click .remove": "deletePage"
      "change select": "updatePage"
      
    updatePage: ->
      @model.set
        "number": @$el.find(".number").text()
        "layout": @$el.find(".layout").val()
        "article": @$el.find(".article").val()
      @model.save

    deletePage: ->
      @model.destroy
        success: ->

  class PageListView extends Backbone.Marionette.CollectionView
    itemView: PageListItemView
