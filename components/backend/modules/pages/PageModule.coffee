define [
    'cs!App'
    'cs!Router'
    'cs!utils'
    'i18n!modules/pages/nls/language.js'
    "text!modules/pages/configuration.json"
    'cs!modules/pages/controller/PageController'
    'cs!modules/pages/model/Pages'
], ( App, Router, Utils, i18n, Config, Controller, Pages ) ->

  App.Pages = new Pages
  App.Pages.fetch
    success:->

  Router.processAppRoutes new Controller,
    "newPage": "addPage"
    "page/:id": "detailsPage"
    "pages": "pages"

  Utils.addModule Config, i18n