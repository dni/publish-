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
      "click .cancel": "cancel"

    save: -> @detailRegion.currentView.save()
    cancel: ->
      Vent.trigger 'app:closeRegion', 'contentRegion'
      App.Router.navigate 'settings'

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
