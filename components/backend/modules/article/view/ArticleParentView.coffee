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
      @files = new Files()
      files = App.Files.where relation: "article:"+@model.get "_id"

      self = @
      _.each files, (file) -> self.files.add file

      @detailRegion.show new DetailView model: @model

      view = new PreviewView collection: @files
      @fileRegion.show view

      view.$el.sortable(
        revert: true
        axis: "y"
        cursor: "move"
        # stop: _.bind @_sortStop, @
      ).disableSelection()


    events:
      "blur .form-control": "saveArticle"
      "click #files": "addFiles"
      "click .delete": "deleteArticle"
      'click #publish': "publishArticle"

    addFiles:->
      App.Router.navigate("filebrowser/article/" + @model.get("_id"), {trigger:true})

    publishArticle: ->
      @model.togglePublish()
      @model.save()

    saveArticle: ->
      @model.set
        title: $("input[name=title]").val()
        author: $("input[name=author]").val()
        desc: $("textarea[name=article]").val()
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
