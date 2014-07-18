define [
  'cs!Publish'
  'marionette'
  'tpl!../templates/layout.html'
  'cs!../../files/view/PreviewView'
], (Publish, Marionette, Template, PreviewView) ->
  class Layout extends Marionette.Layout

    template: Template
    templateHelpers:
      vhs: Publish.Utils.Viewhelpers

    regions:
      'detailRegion': '.details'
      'fileRegion': '.files'

    initialize: (args) ->
      @files = args['files']
      @on "render", @afterRender

    afterRender:->
      @detailRegion.show new @DetailView model: @model
      that = @
      fileAction = ->
        that.fileRegion.show new PreviewView
          collection: that.files
          namespace: 'article'
          modelId: that.model.get "_id"

      # dont create files if model is new and there no _id for the relation
      if !@model.isNew() then fileAction() else @model.on "sync", fileAction

    destroy: ->
      @files.each (file)-> file.destroy success:->
      @detailRegion.currentView.destroy()
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'