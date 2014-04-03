define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ArticleListView'
  'cs!../view/ArticleLayout'
  'cs!../view/TopView'
  'cs!../model/Article'
  'cs!../../files/model/Files'
], ( Vent, $, _, Backbone, Marionette, ArticleListView, ArticleLayout, TopView, Article, Files ) ->

  class ArticleController extends Backbone.Marionette.Controller

    settings: (attr)->
      (App.Settings.findWhere name: "Articles").getValue(attr)

    details: (id) ->
      Vent.trigger 'app:updateRegion', "contentRegion", new ArticleLayout
        model: App.Articles.findWhere _id: id
        files: new Files App.Files.where relation: "article:"+id

    add: ->
      Vent.trigger 'app:updateRegion', 'contentRegion', new ArticleLayout
        model: new Article author: @settings("defaultAuthor")
        files: new Files

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ArticleListView collection: App.Articles