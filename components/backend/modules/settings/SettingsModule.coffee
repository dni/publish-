define [
    'marionette'
    'cs!../../Command'
    'cs!./model/Settings'
    'cs!./router/SettingsRouter'
    "text!./configuration.json"
],
( Marionette, Command, Settings, Router, Config ) -> 

  Command.setHandler "app:ready", ()->   
    App.Settings = new Settings
    App.Settings.fetch
      success:->
    App.SettingsRouter = new Router
    
    Command.execute "app:addModule", JSON.parse Config

