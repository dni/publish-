define [
  'cs!App'
  'cs!utils'
  'io'
  'jquery'
], ( App, Utils, io, $ ) ->

  # Event - app:updateRegion
  Utils.Vent.on 'app:updateRegion', (region, view, cb)->
    App[region].show view
    if cb? then cb()

  # Event - app:closeRegion
  Utils.Vent.on 'app:closeRegion', (region)->
    App[region].close()

  # Event - overlay:action
  Utils.Vent.on 'overlay:action', (cb)->
    $("body").unbind "overlay:ok"
    $("body").on "overlay:ok", cb