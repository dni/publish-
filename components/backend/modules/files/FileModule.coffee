define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/Files'
    'cs!./controller/FileController'
    "text!./configuration.json"
],
( Marionette, Vent, Files, Controller, Config ) ->


  Vent.on "app:ready", ()->

    Vent.trigger "app:addModule", JSON.parse Config
    App.Files = new Files
    App.Files.fetch
      success:->

    App.Router.processAppRoutes new Controller,
      "files": "list"
      "filebrowser": "browser"

    Vent.trigger "files:ready"

    Vent.on "files:browse", -> App.Router.trigger "browser"
