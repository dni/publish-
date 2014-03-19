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
      @model.bind 'change', @render, @
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



    ui:
      edit: ".edit"
      preview: ".preview"
      inputTitle: 'input[name=title]'
      inputAuthor: 'input[name=author]'
      inputArticle: 'textarea[name=article]'
      files: '#files'

    events:
      "click #edit": "toggleEdit"
      "click .save": "saveArticle"
      "click #files": "addFiles"
      "click .delete": "deleteArticle"
      'click #publish': "publishArticle"

    addFiles:->
      App.Router.navigate("filebrowser/article/" + @model.get("_id"), {trigger:true})

    toggleEdit: ->
      @ui.edit.toggle()
      @ui.preview.toggle()

    publishArticle: ->
      @model.togglePublish()
      @model.save()

    saveArticle: ->
      files = []
      @ui.files.children().each -> files.push $(this).attr('src')
      @model.set
        title: @ui.inputTitle.val()
        author: @ui.inputAuthor.val()
        files: files
        desc: @ui.inputArticle.val()
      if @model.isNew()
        App.Articles.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'article/'+res.attributes._id, false
      else
        @model.save()
      @toggleEdit()

    deleteArticle: ->
      @model.destroy
        success:->
      Vent.trigger 'app:closeRegion', 'contentRegion'
