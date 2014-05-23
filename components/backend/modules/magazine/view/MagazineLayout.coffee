define [
  'cs!utils'
  'marionette'
  'tpl!../templates/layout.html'
  'cs!./PageListView'
  'cs!./MagazineDetailView'
  'cs!modules/files/view/PreviewView'
], (Utils, Marionette, Template, PageListView, DetailView, PreviewView) ->

  class MagazineLayout extends Marionette.Layout

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
      "click .save": "save"
      "click .cancel": "cancel"

    save: ->
      @detailRegion.currentView.save()

    cancel: ->
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'

    initialize: (args) ->
      # custom arguments dont get passed automatically
      @files = args['files']
      @pages = args['pages']
      @on "render", @afterRender, @

    afterRender:->
      @detailRegion.show new DetailView model: @model
      # dont childviews if model is new and there no _id for the relation
      if @model.isNew() then @model.on 'sync', @addChildViews, @ else @addChildViews()

    addChildViews:->
      @pageRegion.show new PageListView
        collection: @pages
        magazine: @model.get "_id"
      @fileRegion.show new PreviewView
        collection: @files
        namespace: 'magazine'
        modelId: @model.get "_id"


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

      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'

