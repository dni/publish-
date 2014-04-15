define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/layout.html'
  'cs!./PageListView'
  'cs!./MagazineDetailView'
  'cs!../../files/view/PreviewView'

], (Vent, $, _, Backbone, Template, PageListView, DetailView, PreviewView) ->

  class MagazineLayout extends Backbone.Marionette.Layout
    # Not required since 'div' is the default if no el or tagName specified
    template: Template

    regions:
      'detailRegion': '#magazine-details'
      'pageRegion': '#pages'
      'fileRegion': '.files'

    ui:
      publish: ".publish"
      title: "[name=title]"

    events:
      "click #download": "downloadPrint"
      "click .deleteMagazine": "deleteMagazine"
      "click .publish": "publish"
      "click .save": "save"
      "click .cancel": "close"

    save: ->
      title = $(@el).find("[name=title]")
      $("#list a").each (i)->
        hrefItem = $(@).prop("href").split("/").pop()
        locDetail = Backbone.history.fragment.split("/").pop()#document.location.hash.split("/").pop()
        if $(@).html()==title.val() && hrefItem!=locDetail
          title.val(title.val()+"-no_double_names_allowed")
      @detailRegion.currentView.save()

    close: ->
      @remove()
      App.Router.navigate 'magazines/'

    initialize: (args) ->
      # custom arguments dont get passed automatically
      @files = args['files']
      @pages = args['pages']
      @on "render", @afterRender, @

    afterRender:->
      @detailRegion.show new DetailView model: @model

      # dont create files, pages if model is new and there no _id for the relationx
      that = @
      modelNotNewAction = ->
        that.pageRegion.show new PageListView
          collection: that.pages
          magazine: that.model.get "_id"
        that.fileRegion.show new PreviewView
          collection: that.files
          namespace: 'magazine'
          modelId: that.model.get "_id"

      if !@model.isNew() then modelNotNewAction() else @model.on "sync", modelNotNewAction


    publish:->
      # before model is toggled
      if @model.get("published") then @ui.publish.addClass("btn-success").text('Publish') else @ui.publish.removeClass("btn-success").text('Unpublish')
      @model.togglePublish()
      @save()

    downloadPrint: ->
       window.open(window.location.origin + '/downloadPrint/' + @model.get("title"),'_blank')

    deleteMagazine: ->
      @pages.each (page)->
        page.destroy
          success:->
      @files.each (file)->
        file.destroy
          success:->
      @model.destroy
        success:->

      Vent.trigger 'app:closeRegion', 'contentRegion'

