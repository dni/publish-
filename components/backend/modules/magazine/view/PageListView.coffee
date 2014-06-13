define [
  'cs!App'
  'cs!utils'
  "cs!modules/settings/model/Settings"
  "i18n!modules/magazine/nls/language.js"
  'marionette'
  'tpl!../templates/page.html',
  'tpl!../templates/page-item.html',
  'cs!../model/Page',
  'jquery.ui'
], (App, Utils, Settings, i18n, Marionette, Template, ItemTemplate, Page, jqueryui) ->

  class PageListItemView extends Marionette.ItemView
    template: ItemTemplate
    templateHelpers:
      getArticles: -> App.Articles.toJSON()
      getLayouts: -> App.Settings.findWhere({name: "Magazines"}).getValue("layouts").split(",")
      getMagazineName: (magazine)-> App.Magazines.findWhere(_id:magazine).get "name"

    ui:
      number: '.number'
      layout: '.layout'
      article: '.article'

    events:
      "click .remove": "deletePage"
      "change select": "updatePage"

    initialize:->
      @model.on 'change', @render
      #save page onrender for initial article
      if !@model.get("article") then @once 'render', @updatePage

    updatePage: ->
      @model.set
        "number": @ui.number.text()
        "layout": @ui.layout.val()
        "article": @ui.article.val()
      @model.save()

    deletePage: ->
      @model.destroy
        success: ->

  class PageListView extends Marionette.CompositeView

    template: Template
    templateHelpers:t:i18n
    itemView: PageListItemView
    itemViewContainer: ".page-list"

    events:
      "click #addPage": 'addPage'

    addPage: ->
      page = new Page
        number: @collection.length+1
        magazine: @magazine

      @collection.create page


    initialize:(args)->
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




