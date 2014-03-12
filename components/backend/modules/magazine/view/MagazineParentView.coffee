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
      @pages = new Pages()
      pages = @model.get "pages"
      self = @
      _.each pages, (page) -> self.pages.add new Page page
      @detailRegion.show new DetailView model: @model
      view = new PageListView collection: @pages
      @pageRegion.show view

      view.$el.sortable(
        revert: true
        axis: "y"
        cursor: "move"
        stop: _.bind @_sortStop, @
      ).disableSelection()


    _sortStop: (event, ui)->
      self = @
      elements =
      $(event.target).find('.number').each (i)->
        elNumber = $(@).text()
        model = self.pages.where({number: elNumber})[0]
        model.attributes.number = (i+1).toString()
        $(@).text(i+1)

    regions:
      'detailRegion': '#magazine-details'
      'pageRegion': '.page-list'

    events:
      "click #edit": "toggleEdit"
      "click .save": "saveMagazine"
      "click .delete": "deleteMagazine"
      'click #publish': "publishMagazine"
      "click #hpub": "generateHpub"
      "click #print": "generatePrint"
      "click #download": "downloadPrint"
      "click #addPage": "addPage"
      "stop .sortable": "sortPages"

    addPage: ->
      @pages.add new Page number: (@pages.length+1).toString()

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
        pages: @pages.toArray()

      if @model.isNew()
        App.Magazines.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'magazine/'+res.attributes._id, false
      else
        @model.save
          success:->
      false

