define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!../templates/page.html',
  'tpl!../templates/page-item.html',
  'cs!../model/Page',
  'jquery.ui'
], ($, _, Backbone, Marionette, Template, ItemTemplate, Page, jqueryui) ->

  class PageListItemView extends Backbone.Marionette.ItemView
    template: ItemTemplate

    ui:
      number: '.number'
      layout: '.layout'
      article: '.article'

    events:
      "click .remove": "deletePage"
      "change select": "updatePage"

    #save page onrender for initial article + layout
    initialize:->
      @model.on 'change', @render
      # @on 'render', @updatePage

    updatePage: ->
      @model.set
        "number": @ui.number.text()
        "layout": @ui.layout.val()
        "article": @ui.article.val()
      @model.save()

    deletePage: ->
      @model.destroy
        success: ->

  class PageListView extends Backbone.Marionette.CompositeView

    template: Template
    itemView: PageListItemView
    itemViewContainer: ".page-list"

    events:
      "click #addPage": 'addPage'

    addPage: ->
      page = new Page
        number: @collection.length+1
        magazine: @magazine
      @collection.create page,
        success:->

    initialize:(args)->
      @collection.sort()
      @magazine = args['magazine']
      @listenTo @collection, 'reset', @render
      @listenTo @collection, 'sort', @render
      @listenTo @, "render", @_sortAble

    _sortAble:->
      @$el.find(".page-list").sortable(
         revert: true
         axis: "y"
         cursor: "move"
         stop: @_sortStop.bind(@)
      ).disableSelection()

    _sortStop: (event, ui)->
      that = @
      @$el.find('.number').each (i)->
        elNumber = $(@).text()
        model = that.collection.findWhere number: parseInt elNumber
        model.set "number", i+1
        model.save()

      @collection.sort()




