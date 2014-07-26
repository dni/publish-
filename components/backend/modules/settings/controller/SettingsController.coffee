define [
  'cs!App'
  'cs!Publish'
  'cs!utils'
  'jquery'
],
( App, Publish, Utils, $) ->
  class SettingsController extends Publish.Controller

    routes:
      "settings/clearCache": "clearCache"

    clearCache: ->
      $.get "/clearCache", ->
        window.location = "/admin#settings"
