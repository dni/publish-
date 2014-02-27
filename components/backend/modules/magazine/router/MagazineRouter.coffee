define [
    'marionette'
    "cs!../controller/MagazineController"
],
( Marionette, Controller ) ->

  class MagazineRouter extends Marionette.AppRouter

    controller: new Controller

    appRoutes:
      "magazine/new": "addMagazine"
      "magazine/:id": "detailsMagazine"
      "magazines": "magazines"