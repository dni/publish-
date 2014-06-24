define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'marionette'
  'tpl!../templates/layout.html'
  'cs!../view/SettingsDetailView'
  'cs!modules/files/view/PreviewView'
  'i18n!modules/settings/nls/language.js'

], (App, Router, Utils, Marionette, Template, DetailView, PreviewView, i18n)->
  class SettingsLayout extends Marionette.Layout

    template: Template
    templateHelpers: vhs: Utils.Viewhelpers
    events:
      "click .save": "save"
      "click .delete": "reset"
      "click .cancel": "cancel"

    save: -> @detailRegion.currentView.save()
    reset: -> @detailRegion.currentView.reset()

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
          description: i18n.fileDescription
          modelId: @model.get "_id"
