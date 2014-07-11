define [
    'cs!App'
    'cs!Publish'
    'cs!./controller/UserController'
    'text!./configuration.json'
    'i18n!modules/user/nls/language.js'
], ( App, Publish, Controller, Config, i18n ) ->

  new Publish.Module
    Controller: Controller
    Config: Config
    i18n: i18n