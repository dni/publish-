define [
    'cs!App'
    'cs!Router'
    'cs!utils'
    "text!modules/magazine/configuration.json"
    'cs!modules/magazine/controller/MagazineController'
    'cs!modules/magazine/model/Magazines'
], ( App, Router, Utils, Config, Controller, Magazines ) ->

    App.Magazines = new Magazines
    App.Magazines.fetch
      success:->

    Router.processAppRoutes new Controller,
      "newMagazine": "addMagazine"
      "magazine/:id": "detailsMagazine"
      "magazines": "magazines"

    Utils.addModule Config