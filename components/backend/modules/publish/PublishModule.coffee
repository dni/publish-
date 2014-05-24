define [
  'cs!App'
  'cs!utils'
  'text!modules/publish/configuration.json'
  'cs!modules/publish/model/NavigationItem'
  'cs!modules/publish/model/NavigationItems'
  'cs!modules/publish/view/NavigationView'
],
( App, Utils, Config, NavigationItem, NavigationItems, NavigationView)->

  # show navigation
  App.navigationRegion.show new NavigationView collection: NavigationItems

  # events
  Utils.Vent.on "publish:addNavItem", (config, i18n)->
    config.label = i18n.navigation if i18n
    NavigationItems.add new NavigationItem config

  # add Module Config
  Utils.addModule Config

