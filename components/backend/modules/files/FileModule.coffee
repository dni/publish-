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
      "file/:id": "show"
      "showfile/:id": "showfile"
      "filebrowser/:collection/:id": "filebrowser"

    Vent.trigger "files:ready"

