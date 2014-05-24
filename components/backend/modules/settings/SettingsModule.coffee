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
      Utils.Vent.trigger "settings:ready"

  Utils.Vent.on "settings:addSetting", (name, settings, i18n)->
    setting = App.Settings.where name: name
    if setting.length is 0
      setting = new Setting
      setting.set "settings", settings
      setting.set "name", name
      if i18n then setting.translate i18n
      App.Settings.create setting
    else
      if i18n then setting[0].translate i18n, -> setting[0].save()


  Utils.addModule Config