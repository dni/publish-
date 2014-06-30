define [
    'cs!Publish'
    'text!./configuration.json'
    'i18n!modules/mymodule/nls/language.js'
    'cs!./model/MyCollection'
    'cs!./controller/MyController'
], ( Publish, Config, i18n, MyCollection, MyController ) ->

  class MyModule extends Publish.Module
    Config: Config
    Controller: MyController
    Collection: MyCollection
    i18n: i18n

  new MyModule