define [
  'cs!App'
  'cs!utils'
  'text!modules/publish/configuration.json'
  'cs!modules/publish/model/NavigationItem'
  'cs!modules/publish/model/NavigationItems'
  'cs!modules/publish/view/NavigationView'
],
( App, Utils, Config, NavigationItem, NavigationItems, NavigationView)->

  App.navigationRegion.show new NavigationView collection: NavigationItems

  # events
  Utils.Vent.on "publish:addNavItem", (config)->
    NavigationItems.add new NavigationItem config

  # add Module Config
  Utils.Vent.trigger "app:addModule", JSON.parse Config

