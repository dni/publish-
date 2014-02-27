define [
  'cs!../../../Command'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ArticleListView'
  'cs!../view/ArticleDetailView'
  'cs!../model/Article'
  'cs!../view/ListView' 
],
( Command, $, _, Backbone, Marionette, ArticleListView, ArticleDetailView, Article, ListView ) ->

  class ArticleController extends Backbone.Marionette.Controller

    detailsArticle: (id) ->
      article = App.Articles.where _id: id
      Command.execute 'app:updateRegion', "contentRegion", new ArticleDetailView model: article[0]
      # App.uploadHandler '#images', article

    addArticle: ->
      view = new ArticleDetailView model: new Article
      Command.execute 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()
      
      # view = new ArticleDetailView model: model
      # App.contentRegion.show view
      # App.uploadHandler '#images', model

    articles: ->
      Command.execute 'app:updateRegion', 'listTopRegion', new ListView
      Command.execute 'app:updateRegion', 'listRegion', new ArticleListView collection: App.Articles