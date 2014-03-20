define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/container.html'
  'cs!../model/Pages'
  'cs!../model/Page'
  'cs!./PageListView'
  'cs!./MagazineDetailView'
  'cs!../../files/model/Files'
  'cs!../../files/model/File'
  'cs!../../files/view/PreviewView'

], (Vent, $, _, Backbone, Template, Pages, Page, PageListView, DetailView, Files, File, PreviewView) ->

  class MagazineParentView extends Backbone.Marionette.Layout
    # Not required since 'div' is the default if no el or tagName specified
    template: Template

    regions:
      'detailRegion': '#magazine-details'
      'pageRegion': '.page-list'
      'fileRegion': '.file-list'


    events:
      "click #edit": "toggleEdit"
      "click .save": "saveMagazine"
      "click .delete": "deleteMagazine"
      'click #publish': "publishMagazine"
      "click #download": "downloadPrint"
      "click #addPage": "addPage"
      "stop .sortable": "sortPages"
      "click .publish": "publish"
      "click #files": "addFiles"
      "click .preview-item": "showFile"



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

      @files = new Files()
      files = App.Files.where relation: "magazine:"+@model.get "_id"

      _.each files, (file) -> self.files.add file

      @detailRegion.show new DetailView model: @model

      view = new PreviewView collection: @files
      @fileRegion.show view

      view.$el.sortable(
        revert: true
        cursor: "move"
      ).disableSelection()

    addFiles:->
      App.Router.navigate("filebrowser/magazine/" + @model.get("_id"), {trigger:true})

    showFile: (e)->
      App.Router.navigate("showfile/" + $(e.target).attr("data-uid"), {trigger:true})

    _sortStop: (event, ui)->
      self = @
      elements =
      $(event.target).find('.number').each (i)->
        elNumber = $(@).text()
        model = self.pages.where({number: elNumber})[0]
        if model?
          model.attributes.number = (i+1).toString()
        else
          c.l "model nr.#{elNumber} is broken"
        $(@).text(i+1)


    publish: ->
      @model.togglePublish()
      @model.save()

    addPage: ->
      @pages.add new Page number: (@pages.length+1).toString()

    toggleEdit: ->
      @$el.find('.edit').toggle()
      @$el.find('.preview').toggle()
      @$el.find('.saved').toggle()

    downloadPrint: ->
       window.open(window.location.origin + '/downloadPrint/' + @model.get("title"),'_blank')

    saveMagazine: ->
      @model.set
        title: $('input[name=title]').val()
        author: $('input[name=author]').val()
        impressum: $('textarea[name=impressum]').val()
        editorial: $('textarea[name=editorial]').val()
        cover: $("#cover output img").attr("src")
        back: $("#back output img").attr("src")
        papersize: $(".papersize").val()
        orientation: $(".orientation").val()
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

    deleteMagazine: ->
      @model.destroy
        success:->

      Vent.trigger 'app:closeRegion', 'contentRegion'

