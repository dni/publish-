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
