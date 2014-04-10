define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/layout.html'
  'cs!../view/SettingsDetailView'
  'cs!../../files/view/PreviewView'
], (Vent, $, _, Backbone, Template, DetailView, PreviewView) ->

  class SettingLayout extends Backbone.Marionette.Layout

    template: Template

    events:
      "click .save": "save"
      "click .cancel": "close"

    save: -> @detailRegion.currentView.save()
    close: -> @remove()

    regions:
      'detailRegion': '#setting-details'
      'fileRegion': '.files'

    initialize: (args) ->
      @files = args['files']
      @on "render", @afterRender

    afterRender:->
      @detailRegion.show new DetailView model: @model
      if @model.get("settings").fileView
        @fileRegion.show new PreviewView
          collection: @files
          namespace: 'setting'
          modelId: @model.get "_id"
