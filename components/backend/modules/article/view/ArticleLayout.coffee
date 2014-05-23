define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'marionette'
  'tpl!modules/article/templates/layout.html'
  'cs!modules/article/view/ArticleDetailView'
  'cs!modules/files/view/PreviewView'
], (App, Router, Utils, Marionette, Template, DetailView, PreviewView) ->
  class ArticleLayout extends Marionette.Layout

    template: Template

    regions:
      'detailRegion': '#article-details'
      'fileRegion': '.files'

    initialize: (args) ->
      @files = args['files']
      @on "render", @afterRender

    afterRender:->
      @detailRegion.show new DetailView model: @model

      that = @
      fileAction = ->
        that.fileRegion.show new PreviewView
          collection: that.files
          namespace: 'article'
          modelId: that.model.get "_id"

      # dont create files if model is new and there no _id for the relation
      if !@model.isNew() then fileAction() else @model.on "sync", fileAction

    ui:
      publish: "#publish"

    events:
      "click .delete": "deleteArticle"
      "click .save": "save"
      "click .cancel": "cancel"

    save: -> @detailRegion.currentView.save()

    cancel: ->
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'
      Router.navigate 'articles', trigger:true



    deleteArticle: ->
      @files.each (file)-> file.destroy success:->
      @model.destroy success:->
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'
