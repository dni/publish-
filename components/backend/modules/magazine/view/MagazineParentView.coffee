define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/container.html'
  'cs!../model/Pages'
  'cs!../model/Page'
  'cs!./PageListView'
  'cs!./MagazineDetailView'
], ( $, _, Backbone, Template, Pages, Page, PageListView, DetailView) ->

  class MagazineParentView extends Backbone.Marionette.Layout
    # Not required since 'div' is the default if no el or tagName specified
    template: Template

    initialize:->
      @model.on "change", @render
      @on "render", @afterRender

    afterRender:->


      # @pages = new Pages(pages)

      # newPageArr=[]
      # _.each pages, (page) ->
        # pge = new Page({number: page.number, article: page.article, layout: page.layout})
        # newPageArr.push(pge)
      # @pages.add(newPageArr)

      @detailRegion.show new DetailView model: @model
      @pageRegion.show new PageListView

    regions:
      'detailRegion': '#magazine-details'
      'pageRegion': '#page-list'

    events:
      "click #edit": "toggleEdit"
      "click .save": "saveMagazine"
      "click .delete": "deleteMagazine"
      'click #publish': "publishMagazine"
      "click #addPage": "addPage"
      "click #hpub": "generateHpub"
      "click #print": "generatePrint"
      "click #download": "downloadPrint"

    pageCount: 0

    addPage: ->
      newPage = new Page({number: @pageCount++})
      @pages.add newPage
      c.l @pages
      #@pageRegion.show new PageListView collection:@pages, articles: "articleAAA"


    toggleEdit: ->
      @$el.find('.edit').toggle()
      @$el.find('.preview').toggle()
      @$el.find('.saved').toggle()

    downloadPrint: ->
       form = $ '<form>',
          action: '/downloadPrint'
          method: 'POST'

       form.append $ '<input>',
          name: 'title'
          value: @model.get "title"

       form.submit();

    generateHpub: ->
      c.l "HBUP"
      $.post "/generate",
        id: @model.get "_id"
        title: @model.get "title"
      , (data) -> console.log data

    generatePrint: ->
      $.post "/generatePrint",
        id: @model.get "_id"
        title: @model.get "title"
      , (data) -> console.log data
    saveMagazine: ->
      @model.set
        title: $('input[name=title]').val()
        impressum: $('textarea[name=impressum]').val()
        editorial: $('textarea[name=editorial]').val()
        cover: $("#cover output img").attr("src")
        back: $("#back output img").attr("src")
        pages: @pages#.toJSON()
      if @model.isNew()
        App.Magazines.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'magazine/'+res.attributes._id, false
      else
        @model.save

          success:->
      false
      c.l "model saved.,",@model

