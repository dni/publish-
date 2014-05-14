define [
    'cs!modules/publish/App'
    'marionette'
    'cs!utils'
    'cs!modules/magazine/model/Magazines'
    'cs!modules/magazine/controller/MagazineController'
    "text!modules/magazine/configuration.json"
],
( App, Marionette, Utils, Magazines, Controller, Config ) ->
  c.l App

  Utils.Vent.on "app:ready", ()->

    Utils.Vent.trigger "app:addModule", JSON.parse Config
    App.Magazines = new Magazines
    App.Magazines.fetch
      success:->

    App.Router.processAppRoutes new Controller,
      "newMagazine": "addMagazine"
      "magazine/:id": "detailsMagazine"
      "magazines": "magazines"

    Utils.Vent.trigger "magazine:ready"