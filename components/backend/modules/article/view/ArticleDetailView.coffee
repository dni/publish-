define ['jquery', 'lodash', 'backbone', 'tpl!../templates/detail.html'], ( $, _, Backbone, Template) ->

  class ArticleDetailView extends Backbone.Marionette.ItemView
    template: Template
    events:
      "click #edit": "toggleEdit"
      "click .save": "saveArticle"
      "click .delete": "deleteArticle"
      'click #publish': "publishArticle"

    ui:
      inputTitle: 'input[name=title]'
      inputAuthor: 'input[name=author]'
      inputArticle: 'textarea[name=article]'
  
    toggleEdit: ->
      @$el.find('.edit').toggle();
      @$el.find('.preview').toggle();
      @$el.find('.saved').toggle();

    publishArticle: ->
      @model.togglePublish()
      @model.save()

    saveArticle: ->
      console.log @model
      files = []
      $('#files').children().each -> files.push $(this).attr('src')
      
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
        @render()
      @trigger('toggleEdit')
      false

    deleteArticle: ->
      @model.destroy 
      App.ArticleRouter.navigate "/articles", false
