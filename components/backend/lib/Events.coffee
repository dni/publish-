define [
  'cs!App'
  'cs!utils'
  'jquery'
], ( App, Utils, $ ) ->

  # Event - overlay:action
  Utils.Vent.on 'overlay:action', (cb)->
    $("body").unbind "overlay:ok"
    $("body").on "overlay:ok", cb
