define [
    'marionette'
    'cs!../../Command'
    'cs!./model/Articles'
    'cs!./router/ArticleRouter'
    "text!./configuration.json"
],
( Marionette, Command, Articles, Router, Config ) -> 

  module = {
    name: "ArticleModule"
    config: JSON.parse Config
  }

  Command.setHandler "app:ready", ()->   
    App.Articles = new Articles
    App.Articles.fetch
    App.ArticleRouter = new Router
    Command.execute "app:addModule", module


  
