define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  "text!./configuration.json"
  'cs!./model/Files'
  'cs!./controller/FileController'
],( App, Router, Utils, Config, Files, Controller ) ->

  App.Files = new Files
  App.Files.fetch
    success:->

  Router.processAppRoutes new Controller,
    "files": "list"
    "file/:id": "show"
    "showfile/:id": "showfile"
    "filebrowser/:collection/:id": "filebrowser"

  Utils.addModule Config

