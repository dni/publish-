define [
    'marionette'
    'cs!../../Vent'
    'cs!./model/Articles'
    'cs!./controller/ArticleController'
    "text!./configuration.json"
],
( Marionette, Vent, Articles, Controller, Config ) -> 

  
  Vent.on "app:ready", ()->
  
    Vent.trigger "app:addModule", JSON.parse Config
  
    App.Articles = new Articles
    App.Articles.fetch
      success:->
        
    App.Router.processAppRoutes new Controller,
      "articles": "list"
      "article/:id": "details"
      "newArticle": "add"
      
    Vent.trigger "article:ready"
      