define [
    'cs!Publish'
    'text!./configuration.json'
    'i18n!./nls/configuration.js'
], ( Publish, Config, i18n) ->

  new Publish.Module
    Config: Config
    i18n:i18n
