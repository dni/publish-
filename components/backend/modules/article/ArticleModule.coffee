define [
    'cs!App'
    'cs!Router'
    'cs!utils'
    'text!./configuration.json'
    'cs!./model/Articles'
    'cs!./controller/ArticleController'
], ( App, Router, Utils, Config, Articles, Controller ) ->

  App.Articles = new Articles
  App.Articles.fetch
    success:->

  Router.processAppRoutes new Controller,
    "articles": "list"
    "article/:id": "details"
    "newArticle": "add"

  Utils.addModule Config
