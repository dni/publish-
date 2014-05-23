define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'marionette'
  'tpl!modules/article/templates/detail.html'
  'i18n!modules/article/nls/language.js'
], (App, Router, Utils, Marionette, Template, i18n) ->

  class ArticleDetailView extends Marionette.ItemView

    template: Template
    templateHelpers:
      t: i18n
      renderCategories: (category, func)->
        cats = (App.Settings.findWhere name:'Articles').getValue "categories"

        for cat in cats.split ','
          cat = cat.replace " ", ""
          if cat is category then func cat, 'selected' else func cat, ''

    ui:
      title: '[name=title]'
      author: '[name=author]'
      article: '[name=article]'
      tags: '[name=tags]'
      category: '[name=category]'
      publish: '.publish'

    events:
      'click .publish': 'publish'

    publish: ->
      if @model.get("published") then @ui.publish.addClass("btn-success").text('Publish') else @ui.publish.removeClass("btn-success").text('Unpublish')
      @model.togglePublish()
      @save()

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
            Utils.Log i18n.newArticle, 'new',
              text: res.attributes.title
              href: route

            Router.navigate route, false
      else
        Utils.Log i18n.updateArticle, 'update',
          text: @model.get 'title'
          href: 'article/'+@model.get '_id'

        @model.save()

