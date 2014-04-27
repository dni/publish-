define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
  'i18n!../nls/language.js'
], ($, _, Backbone, Template, i18n) ->

  class ArticleDetailView extends Backbone.Marionette.ItemView

    template: Template
    templateHelpers: t: i18n

    ui:
      title: '[name=title]'
      author: '[name=author]'
      article: '[name=article]'
      tags: '[name=tags]'
      category: '[name=category]'

    save: ->
      @model.set
        title: @ui.title.val()
        author: @ui.author.val()
        desc: @ui.article.val()
        category: @ui.category.val()
        tags: @ui.tags.val()

      if @model.isNew()
        App.Articles.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'article/'+res.attributes._id, false
      else
        @model.save()

