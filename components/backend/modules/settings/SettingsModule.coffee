define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./controller/SettingsController'
    "text!./configuration.json"
],
( Marionette, Vent, Controller, Config ) -> 

  Vent.on "app:ready", ()-> 
  
    Vent.trigger "app:addModule", JSON.parse Config
    
    App.Router.processAppRoutes new Controller,
      "settings": "list"
      "settings/:id": "details"
      
    Vent.trigger "settings:ready"
      
      
