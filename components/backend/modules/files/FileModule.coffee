define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  "i18n!modules/files/nls/language.js"
  "text!./configuration.json"
  'cs!./model/Files'
  'cs!./controller/FileController'
  'less!./style/browse.less'
],( App, Router, Utils, i18n, Config, Files, Controller ) ->

  App.Files = new Files
  App.Files.fetch
    success:->

  Router.processAppRoutes new Controller,
    "files": "list"
    "file/:id": "show"
    "showfile/:id": "showfile"
    "editfile/:id": "editfile"
    "filebrowser/:collection/:id": "filebrowser"

  Utils.addModule Config, i18n

