define [
  'cs!utilities'
  'cs!App'
  'io'
], ( Utilities, App, io ) ->

  App.addInitializer ->

    Utilities.Vent.on 'app:addModule', (config)->
      App.Modules[config.config.name] = config.config
      if config.navigation then App.navItems.add new NavItem config.navigation
      if config.settings then settings.push
        settings:config.settings
        name:config.config.name

    Utilities.Vent.trigger config.config.namespace+":ready"

    Utilities.Vent.on 'app:updateRegion', (region, view, cb)->
      App[region].show view
      if cb? then cb()

    Utilities.Vent.on 'app:closeRegion', (region)->
      App[region].close()

    Utilities.Vent.on 'overlay:action', (cb)->
      $("body").unbind "overlay:ok"
      $("body").on "overlay:ok", cb