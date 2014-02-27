define [
    'marionette'
    'cs!../../Command'
    'cs!./model/Settings'
    'cs!./router/SettingsRouter'
    "text!./configuration.json"
],
( Marionette, Command, Settings, Router, Config ) -> 

  Command.setHandler "app:ready", ()->   
    App.Articles = new Articles
    App.Articles.fetch
      success:->
    App.ArticleRouter = new Router
    
    Command.execute "app:addModule", JSON.parse Config

