define [
    'cs!Publish'
    'text!./configuration.json'
    'i18n!./nls/language.js'
], ( Publish, Config, i18n) ->

  new Publish.Module
    Controller: Publish.Controller.LayoutController
    Config: Config
    i18n:i18n
