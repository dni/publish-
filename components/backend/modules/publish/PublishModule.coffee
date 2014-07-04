define [
  'cs!App'
  'cs!utils'
  'i18n!modules/publish/nls/language.js'
  'text!modules/publish/configuration.json'
  'cs!modules/publish/model/NavigationItem'
  'cs!modules/publish/model/NavigationItems'
  'cs!modules/publish/view/NavigationView'
  'cs!lib/Regions'
  'cs!lib/Events'
  'cs!lib/Socket'
  "css!vendor/minicolors/jquery.minicolors.css"
  "less!lib/style/main"
],
( App, Utils, i18n, Config, NavigationItem, NavigationItems, NavigationView)->

  # show navigation
  App.navigationRegion.show new NavigationView collection: NavigationItems

  # events
  Utils.Vent.on "publish:addNavItem", (config, i18n)->
    config.label = i18n.navigation if i18n
    NavigationItems.add new NavigationItem config
    App.NavigationItems = NavigationItems

  # add Module Config
  Utils.addModule Config, i18n

