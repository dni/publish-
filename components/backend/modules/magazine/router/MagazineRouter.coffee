define [
    'jquery'
    'lodash'
    'backbone'
    'marionette'
],
( $, _, Backbone, Marionette ) ->

  class MagazineRouter extends Backbone.Marionette.Router
    
    appRoutes:
      "magazine/new": "addMagazine"
      "magazine/:id": "detailsMagazine"
      "magazines": "magazines"
      "generator": "generator"