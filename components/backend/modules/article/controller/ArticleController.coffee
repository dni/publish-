define [
  'cs!App'
  'cs!utils'
  'marionette'
  'i18n!modules/article/nls/language.js'
  'cs!modules/article/view/ArticleListView'
  'cs!modules/article/view/ArticleLayout'
  'cs!utilities/views/TopView'
  'cs!modules/article/model/Article'
  'cs!modules/files/model/Files'
  'cs!utilities/views/EmptyView'
], ( App, Utils, Marionette, i18n, ArticleListView, ArticleLayout, TopView, Article, Files, EmptyView ) ->

  class ArticleController extends Marionette.Controller
    settings: (attr)->
      (App.Settings.findWhere name: "Articles").getValue(attr)

    details: (id) ->
      article = App.Articles.findWhere _id: id
      if article
        Utils.Vent.trigger 'app:updateRegion', "contentRegion", new ArticleLayout
          model: article
          files: new Files App.Files.where relation: "article:"+id
      else
        Utils.Vent.trigger 'app:updateRegion', "contentRegion", new EmptyView message: i18n.emptyMessage

    add: ->
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', new ArticleLayout
        model: new Article author: @settings("defaultAuthor")
        files: new Files

    list: ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView navigation: i18n.navigation, newModel: 'newArticle'
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new ArticleListView collection: App.Articles
