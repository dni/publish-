define ['jquery', 'lodash', 'backbone', 'tpl!../templates/detail.html'], ( $, _, Backbone, Template) ->

  class ArticleDetailView extends Backbone.Marionette.ItemView
    
    template: Template

    initialize: ->
      @model.bind 'change', @render, @    

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
      "click .delete": "deleteArticle"
      'click #publish': "publishArticle"
    
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
        images: files
        desc: @ui.inputArticle.val()
      if @model.isNew()
        App.Articles.create @model,
          wait: true
          success: (res) ->
            App.ArticleRouter.navigate 'article/'+res.attributes._id, false
      else
        @model.save()
      @toggleEdit()

    deleteArticle: ->
      # TODO, bug: backbone doesnt send the delete request
      App.Articles.remove @model.cid
      @model.destroy
        success:->
          App.ArticleRouter.navigate "/articles", true
