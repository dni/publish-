define [
  'cs!App'
  'cs!utils'
  'marionette'
  'cs!modules/article/view/ArticleListView'
  'cs!modules/article/view/ArticleLayout'
  'cs!modules/article/view/TopView'
  'cs!modules/article/model/Article'
  'cs!modules/files/model/Files'
], ( App, Utils, Marionette, ArticleListView, ArticleLayout, TopView, Article, Files ) ->

  class ArticleController extends Marionette.Controller
    settings: (attr)->
      (App.Settings.findWhere name: "Articles").getValue(attr)

    details: (id) ->
      Utils.Vent.trigger 'app:updateRegion', "contentRegion", new ArticleLayout
        model: App.Articles.findWhere _id: id
        files: new Files App.Files.where relation: "article:"+id

    add: ->
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', new ArticleLayout
        model: new Article author: @settings("defaultAuthor")
        files: new Files

    list: ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new ArticleListView collection: App.Articles