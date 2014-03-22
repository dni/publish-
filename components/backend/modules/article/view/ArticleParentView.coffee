define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/container.html'
  'cs!../model/Article'
  'cs!../../files/model/Files'
  'cs!../../files/model/File'
  'cs!../view/ArticleDetailView'
  'cs!../../files/view/PreviewView'
], (Vent, $, _, Backbone, Template, Article, Files, File, DetailView, PreviewView) ->

  class ArticleParentView extends Backbone.Marionette.Layout

    template: Template

    regions:
      'detailRegion': '#article-details'
      'fileRegion': '.file-list'

    initialize: ->
      @on "render", @afterRender

    afterRender:->
      @fileRegion.show new PreviewView collection: new Files App.Files.where relation: "article:"+@model.get "_id"
      @detailRegion.show new DetailView model: @model

    events:
      "blur .form-control": "saveArticle"
      "click #files": "addFiles"
      "click .preview-item": "showFile"
      "click .delete": "deleteArticle"
      'click #publish': "publishArticle"

    addFiles:->
      App.Router.navigate("filebrowser/article/" + @model.get("_id"), {trigger:true})

    showFile: (e)->
      App.Router.navigate("showfile/" + $(e.target).attr("data-uid"), {trigger:true})

    publishArticle: (e)->
      $btn = $(e.target)
      if @model.get("privatecode") then $btn.removeClass("btn-success").text('Unpublish') else $btn.addClass("btn-success").text('Publish!')
      @model.togglePublish()
      @model.save()

    saveArticle: ->
      @model.set
        title: @$el.find("[name=title]").val()
        author: @$el.find("[name=author]").val()
        desc: @$el.find("[name=article]").val()
      if @model.isNew()
        App.Articles.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'article/'+res.attributes._id, false
      else
        @model.save()

    deleteArticle: ->
      @model.destroy
        success:->
      Vent.trigger 'app:closeRegion', 'contentRegion'
