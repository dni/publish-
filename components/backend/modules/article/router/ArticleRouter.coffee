define [
    'marionette'
    "cs!../controller/ArticleController"
],
( Marionette, Controller ) ->
  
  class ArticleRouter extends Marionette.AppRouter
    
    controller: new Controller
    
    appRoutes:
      "article/new": "addArticle"
      "article/:id": "detailsArticle"
      "articles": "articles"