define [
  'cs!../../../Command'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../ArticleModule'
  'cs!../view/ArticleListView'
  'cs!../view/ArticleDetailView'
  'cs!../model/Article'
],
( Command, $, _, Backbone, Marionette, Module, ArticleListView, ArticleDetailView, Article ) ->

  class ArticleController extends Backbone.Marionette.Controller

    detailsArticle: (id) ->
      article = Module.Articles.where _id: id
      Command.trigger 'updateContentRegion', new ArticleDetailView model: article[0]
      # App.uploadHandler '#images', article

    addArticle: ->
      # model = new Article()
      # view = new ArticleDetailView model: model
      # App.contentRegion.show view
      # view.toggleEdit()
      # App.uploadHandler '#images', model

    articles: ->
      console.log Module
      # Command.trigger 'updateContentRegion', new ArticleListView model: Module.Articles