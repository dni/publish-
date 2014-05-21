define [
  'cs!App'
  'cs!utils'
  'io'
  'jquery'
], ( App, Utils, io, $ ) ->

  # Event - app:addModule
  Utils.Vent.on 'app:addModule', (config)->

    #add module setting
    if config.settings
      Utils.Vent.on 'settings:ready', ->
        Utils.Vent.trigger 'settings:addSetting', config.config.name, config.settings

    # add module to navigation
    if config.navigation then Utils.Vent.trigger 'publish:addNavItem', config.navigation

    # fire ready event for every module except settings
    if config.config.namespace != "settings" then Utils.Vent.trigger config.config.namespace+":ready"



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