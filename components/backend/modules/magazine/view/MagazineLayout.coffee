define [
  'cs!utils'
  'marionette'
  'tpl!../templates/layout.html'
  'cs!./PageListView'
  'cs!./MagazineDetailView'
  'cs!modules/files/view/PreviewView'
], (Utils, Marionette, Template, PageListView, DetailView, PreviewView) ->

  class MagazineLayout extends Backbone.Marionette.Layout

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
      "click .cancel": "cancel"

    save: ->
      @detailRegion.currentView.save()

    cancel: ->
      Vent.trigger 'app:closeRegion', 'contentRegion'
      App.Router.navigate 'magazines'

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

