define [
  'backbone'
], (Backbone) ->
  class Setting extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "settings"

    getValue:(val)->
      @.get("settings")[val].value

    translate: (i18n, cb)->
      settings = @.get "settings"
      for key, setting of settings
        if i18n[key]?
          setting.label = i18n[key]
      settings = @.set "settings", settings
      cb() if cb?
