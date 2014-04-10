define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/layout.html'
  'cs!../view/ArticleDetailView'
  'cs!../../files/view/PreviewView'
], (Vent, $, _, Backbone, Template, DetailView, PreviewView) ->

  class ArticleLayout extends Backbone.Marionette.Layout

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
      'click #publish': "publish"
      "click .save": "save"
      "click .cancel": "close"

    save: -> @detailRegion.currentView.save()
    close: -> @remove()

    publish: ->
      if @model.get("privatecode") then @ui.publish.removeClass("btn-success").text('Unpublish') else @ui.publish.addClass("btn-success").text('Publish!')
      @model.togglePublish()
      @save()

    deleteArticle: ->
      @files.each (file)-> file.destroy success:->
      @model.destroy success:->
      Vent.trigger 'app:closeRegion', 'contentRegion'
