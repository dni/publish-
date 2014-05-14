define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./controller/SettingsController'
    "text!./configuration.json"
],
( Marionette, Vent, Controller, Config ) ->

  Vent.on "app:ready", ()->

    Vent.trigger "app:addModule", JSON.parse Config

    Vent.on "settings:addSetting", (name, settings)->
      setting = App.Settings.where name: name
      if setting.length is 0
        setting = new Setting
        setting.set "settings", settings
        setting.set "name", name
        App.Settings.create setting

    App.Router.processAppRoutes new Controller,
      "settings": "list"
      "setting/:id": "details"
      "settings/clearCache": "clearCache"





    App.Settings = new Settings
    App.Settings.fetch
      success:->
        Vent.trigger "settings:ready"


