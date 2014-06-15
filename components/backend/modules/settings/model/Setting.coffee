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
        # translate select options ;)
        if setting.type is "select"
          for optionkey, option of setting.options
            if i18n[optionkey]
              option = i18n[optionkey]
        if i18n[key]
          setting.label = i18n[key]
          if i18n[key+'_description']
            setting.description = i18n[key+'_description']
      settings = @.set "settings", settings
      settings = @.set "label", i18n.navigation
      cb() if cb?
