define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ArticleListView'
  'cs!../view/ArticleParentView'
  'cs!../model/Article'
  'cs!../view/TopView'
], ( Vent, $, _, Backbone, Marionette, ArticleListView, ArticleParentView, Article, TopView ) ->

  class ArticleController extends Backbone.Marionette.Controller

    settings: ->
      App.Settings.where({name: "ArticleModule"})[0]

    details: (id) ->
      article = App.Articles.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new ArticleParentView model: article[0]

    add: ->
      view = new ArticleParentView model:new Article author: @settings().getValue "defaultAuthor"
      Vent.trigger 'app:updateRegion', 'contentRegion', view

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ArticleListView collection: App.Articles