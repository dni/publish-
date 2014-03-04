define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
  'cs!../model/Pages'
  'cs!../model/Page'
  'cs!./PageListView'
],
( $, _, Backbone, Template, Pages, Page, PageListView) ->

  class MagazineDetailView extends Backbone.Marionette.ItemView
    # Not required since 'div' is the default if no el or tagName specified
    template: Template

    initialize: ->
      @pages = new Pages()
      # if @model.get("pages").length > 0
        # pages = []
        # pages[i] = new Page pageJSON for pageJSON, i in @model.get "pages"
        # @pages.reset pages
#
      # @model.bind "change", @render, @


   # render: (eventName) ->
      # @$el.html @template
        # model:@model.toJSON()
        # magazines: App.Magazines.toJSON()
     # @$el.find('#pageList').html @pageList.addAll()
     # @el

    events:
      "click #edit": "toggleEdit"
      "click .save": "saveMagazine"
      "click .delete": "deleteMagazine"
      'click #publish': "publishMagazine"
      "click #addPage": "addPage"
      "click #hpub": "generateHpub"
      "click #print": "generatePrint"
      "click #download": "downloadPrint"

    downloadPrint: ->
       form = $ '<form>',
          action: '/downloadPrint'
          method: 'POST'

       form.append $ '<input>',
          name: 'title'
          value: @model.get "title"


       form.submit();

    generateHpub: ->
      $.post "/generate",
        id: @model.get "_id"
        title: @model.get "title"
      , (data) -> console.log data

    generatePrint: ->
      $.post "/generatePrint",
        id: @model.get "_id"
        title: @model.get "title"
      , (data) -> console.log data

    addPage: ->
      if !@pageList
        el = @$el.find("#pageList")
        @pageList = new PageListView collection: @pages, $el: el
        @pageList.$el = el;
      page = new Page pagecount: @pages.models.length
      @pages.add page

    toggleEdit: ->
      @$el.find('.edit').toggle();
      @$el.find('.preview').toggle();
      @$el.find('.saved').toggle();

    publishMagazine: ->
      @model.togglePublish()
      @model.save()

    saveMagazine: ->
      @model.set
        title: $('input[name=title]').val()
        impressum: $('textarea[name=impressum]').val()
        editorial: $('textarea[name=editorial]').val()
        cover: $("#cover output img").attr("src")
        back: $("#back output img").attr("src")
        pages: @pages
      if @model.isNew()
        self = @;
        App.Magazines.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'magazine/'+res.attributes._id, false
      else
        @model.save()
        @render()
      @trigger('toggleEdit')
      false

    deleteMagazine: ->
      @model.destroy
        success: ->
      App.navigate "/magazines", false
      $("#content").html ""
      false
