define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ArticleListView'
  'cs!../view/ArticleDetailView'
  'cs!../model/Article'
  'cs!../view/TopView'
], ( Vent, $, _, Backbone, Marionette, ArticleListView, ArticleDetailView, Article, TopView ) ->

  class ArticleController extends Backbone.Marionette.Controller

    settings: ->
      App.Settings.where({name: "ArticleModule"})[0]

    details: (id) ->
      article = App.Articles.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new ArticleDetailView model: article[0]

    add: ->
      view = new ArticleDetailView model: new Article author: @settings().getValue "defaultAuthor"
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ArticleListView collection: App.Articles