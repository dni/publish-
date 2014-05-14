define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'marionette'
  'tpl!../templates/layout.html'
  'cs!../view/SettingsDetailView'
  'cs!modules/files/view/PreviewView'
], (App, Router, Utils, Marionette, Template, DetailView, PreviewView)->
  class SettingsLayout extends Marionette.Layout

    template: Template
    events:
      "click .save": "save"
      "click .cancel": "cancel"

    save: -> @detailRegion.currentView.save()

    cancel: ->
      App.contentRegion.close()
      Router.navigate 'settings'

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
