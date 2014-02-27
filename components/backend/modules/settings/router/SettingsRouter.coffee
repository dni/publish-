define [
    'marionette'
    "cs!../controller/SettingsController"
],
( Marionette, Controller ) ->
  
  class SettingsRouter extends Marionette.AppRouter
    
    controller: new Controller
    
    appRoutes:
      "settings/:id": "details"
      "settings": "list"