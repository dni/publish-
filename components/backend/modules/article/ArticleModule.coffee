define [
    'marionette'
    'cs!../../Command'
    'cs!./model/Articles'
    'cs!./router/ArticleRouter'
    "text!./configuration.json"
],
( Marionette, Command, Articles, Router, Config ) -> 

  Command.setHandler "app:ready", ()->   
    App.Articles = new Articles
    App.Articles.fetch
      success:->
    App.ArticleRouter = new Router
    Command.execute "app:addModule", JSON.parse Config