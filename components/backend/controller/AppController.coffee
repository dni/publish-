define [
    'jquery'
    'lodash'
    'backbone'
    'marionette'
    'cs!../views/WelcomeView'
    'cs!../views/LoginView'
],
($, _, Backbone, Marionette, WelcomeView, LoginView ) ->

  class AppController extends Backbone.Marionette.Controller

    generator: ->
      $.get "generator", (data) -> console.log data

    settings: ->
      App.overlayRegion.show new LoginView

    welcome: ->
      console.log new WelcomeView
      App.contentRegion.show new WelcomeView
