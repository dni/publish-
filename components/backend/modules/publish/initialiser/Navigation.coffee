define [
  'cs!utilities'
  'cs!App'
  'cs!../model/NavItems'
  'cs!../view/NavigationView'
], ( Utilities, App, NavItems, NavigationView ) ->

  App.addInitializer ->
    App.navItems = new NavItems
    App.navigationRegion.show new NavigationView collection: App.navItems
