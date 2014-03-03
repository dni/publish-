define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ArticleListView'
  'cs!../view/ArticleDetailView'
  'cs!../model/Article'
  'cs!../view/ListView'
], ( Vent, $, _, Backbone, Marionette, ArticleListView, ArticleDetailView, Article, ListView ) ->

  class ArticleController extends Backbone.Marionette.Controller

    details: (id) ->
      article = App.Articles.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new ArticleDetailView model: article[0]

    add: ->
      view = new ArticleDetailView model: new Article
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new ListView
      Vent.trigger 'app:updateRegion', 'listRegion', new ArticleListView collection: App.Articles