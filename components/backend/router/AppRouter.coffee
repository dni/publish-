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
    onRoute: (name, path, args)->
      c.l name, path, args
