define [
  'cs!App'
  "text!./configuration.json"
  "i18n!modules/settings/nls/language.js"
  'cs!./controller/SettingsController'
], ( App, Config, i18n, Controller ) ->

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

  new Publish.Module
    Controller: Controller