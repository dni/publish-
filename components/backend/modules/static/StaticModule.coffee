define [
    'cs!App'
    'cs!Router'
    'cs!utils'
    'i18n!modules/static/nls/language.js'
    'marionette'
    'cs!./model/StaticBlocks'
    'cs!./controller/StaticBlockController'
    'text!./configuration.json'
], ( App, Router, Utils, i18n, Marionette, StaticBlocks, Controller, Config ) ->

  App.StaticBlocks = new StaticBlocks
  App.StaticBlocks.fetch
    success:->

  Router.processAppRoutes new Controller,
    "staticBlocks": "list"
    "staticBlock/:id": "details"
    "newStaticBlock": "add"

  Utils.addModule Config, i18n
