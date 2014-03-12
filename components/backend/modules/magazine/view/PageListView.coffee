define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../model/Page'
  'cs!../model/Pages'
  'tpl!../templates/pageListItem.html',
  'jquery.ui'
], ($, _, Backbone, Marionette, Page, Pages, Template, jqueryui) ->

  class PageListItemView extends Backbone.Marionette.ItemView
    template: Template

    initialize:->
      @model.on "change", @render, @

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
    tagName: "div"
    className:"sortable"
    itemView: PageListItemView

