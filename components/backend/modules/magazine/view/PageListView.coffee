define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../model/Pages'
  'tpl!../templates/pageListItem.html'
], ($, _, Backbone, Marionette, Pages, Template) ->

  class PageListItemView extends Backbone.Marionette.ItemView
    template: Template
    events:
      "click .remove": "deletePage"
      "change select": "updatePage"


    initialize: ->
      @pages = new Pages()
      @pages.reset @model.get("pages")
      #c.l "model ::: ", @model
      #tpl = _.template(@template, {number: 13, articles: App.Articles})
      #c.l tpl, @template, App.articles

    #render: ->
      #@el = @template


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
    initialize: ->
