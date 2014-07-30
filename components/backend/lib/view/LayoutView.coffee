define [
  'cs!Publish'
  'marionette'
  'tpl!../templates/layout.html'
  'cs!../../files/view/PreviewView'
], (Publish, Marionette, Template, PreviewView) ->
  class LayoutView extends Marionette.LayoutView

    template: Template

    regions:
      'detailRegion': '.details'
      'fileRegion': '.files'

    initialize:->
      @files = new @Collection
      @model.on "destroy", @destroy
      @on "render", @afterRender
    
    showChildViews: ->
      @fileRegion.show new PreviewView
        collection: @files
        moduleName: @Config.moduleName
        modelId: @model.get "_id"


    afterRender:->
      @detailRegion.show new @DetailView model: @model
      # dont create subviews if model is new and there is no _id for the relation
      if !@model.isNew() then @showSubViews() else @model.on "sync", @showSubViews, @

    destroy: ->
      @files.each (file)-> 
        file.destroy success:->
