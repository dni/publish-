define [
    'marionette'
    'cs!../../Vent'
    'cs!./model/Settings'
    'cs!./controller/SettingsController'
    "text!./configuration.json"
],
( Marionette, Vent, Settings, Controller, Config ) -> 

  Vent.on "app:ready", ()-> 
  
    App.Settings = new Settings
    
    App.Router.processAppRoutes new Controller,
      "settings": "list"
      "settings/:id": "details"
      
    Vent.trigger "app:addModule", JSON.parse Config
      
