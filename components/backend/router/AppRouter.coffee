define [
    'jquery'
    'lodash'
    'backbone'
    'marionette'
    'cs!../controller/AppController'
],
( $, _, Backbone, Marionette, Controller ) ->
  class AppRouter extends Marionette.AppRouter
    controller: new Controller
    # appRoutes:
      # "": "welcome"
      # "settings": 'settings'
      # "article/new": "addArticle"
      # "article/:id": "detailsArticle"
      # "articles": "articles"
      # "magazine/new": "addMagazine"
      # "magazine/:id": "detailsMagazine"
      # "magazines": "magazines"
      # "generator": "generator"