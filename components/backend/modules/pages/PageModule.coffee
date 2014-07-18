define [
    'Publish'
    "text!./pages/configuration.json"
    'i18n!modules/pages/nls/language.js'
], (Publish, i18n, Config) ->

  new Publish.Module
    Config:Config
    i18n:i18n