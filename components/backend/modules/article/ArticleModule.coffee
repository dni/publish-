define [
    'marionette'
    'cs!utils'
    'text!./configuration.json'
    'cs!./model/Articles'
    'cs!./controller/ArticleController'
], ( Marionette, Utils, Config, Articles, Controller ) ->
  console.log "module", "article", Config
  Utils.Vent.on "app:ready", ()->
    Utils.Vent.trigger "app:addModule", JSON.parse Config

    App.Articles = new Articles
    App.Articles.fetch
      success:->

    App.Router.processAppRoutes new Controller,
      "articles": "list"
      "article/:id": "details"
      "newArticle": "add"

    Utils.Vent.trigger "article:ready"
