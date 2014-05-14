define [
  'marionette'
  'tpl!modules/article/templates/detail.html'
  # 'i18n!../nls/language.js'
], (Marionette, Template, i18n) ->

  class ArticleDetailView extends Marionette.ItemView

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
            route = 'article/'+res.attributes._id
            App.Utilities.Log i18n.newArticle, 'new',
              text: res.attributes.title
              href: route

            App.Router.navigate route, false
      else
        App.Utilities.Log i18n.updateArticle, 'update',
          text: @model.get 'title'
          href: 'article/'+@model.get '_id'

        @model.save()

