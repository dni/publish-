define [
  'cs!App'
  'cs!utils'
  'cs!Router'
  "text!./configuration.json"
  'cs!./controller/SettingsController'
  'cs!./model/Settings'
  'cs!./model/Setting'
], ( App, Utils, Router, Config, Controller, Settings, Setting ) ->

  Router.processAppRoutes new Controller,
    "settings": "list"
    "setting/:id": "details"
    "settings/clearCache": "clearCache"

  App.Settings = new Settings
  App.Settings.fetch
    success:->
      Utils.Vent.trigger("settings:ready")


  Utils.Vent.on "settings:addSetting", (name, settings, i18n)->
    setting = App.Settings.findWhere name: name
    if !setting
      setting = new Setting
      setting.set "settings", settings
      setting.set "name", name
      setting.set "label", name
      if i18n then setting.translate i18n
      App.Settings.create setting
    else
      if i18n then setting.translate i18n, -> setting.save()


  Utils.addModule Config