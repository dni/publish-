define [
  'cs!Publish'
  'marionette'
  'tpl!../templates/layout.html'
  'cs!modules/files/view/PreviewView'
], (Publish, Marionette, Template, PreviewView) ->
  class LayoutView extends Marionette.LayoutView

    template: Template

    regions:
      'detailRegion': '.details'
      'childRegion': '#childs'

    initialize:(args)->
      @DetailView = args.detailView
      @model = @DetailView.model
      @files = args.files

      @model.on "destroy", @destroy
      @on "render", @afterRender

    showChildViews: ->
      @fileRegion.show new PreviewView
        collection: @files
        moduleName: @Config.moduleName
        modelId: @model.get "_id"


    afterRender:->
      @detailRegion.show @DetailView
      # dont create subviews if model is new and there is no _id for the relation
      if !@model.isNew() then @showChildViews() else @model.on "sync", @showChildViews, @

    destroy: ->
      @files.each (file)->
        file.destroy success:->
