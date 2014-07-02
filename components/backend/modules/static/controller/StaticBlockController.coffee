define [
  'cs!Publish'
  'cs!../view/DetailView'
  'cs!../view/ListView'
  'cs!../model/StaticBlock'
  'cs!../model/StaticBlocks'
  'text!../configuration.json'
  'i18n!modules/static/nls/language.js'
], ( Publish, DetailView, ListView, Model, Collection, Config, i18n) ->

  class StaticController extends Publish.Controller
    Config: Config
    i18n: i18n
    Model: Model
    Collection: Collection
    DetailView: DetailView
    ListView: ListView

  new StaticController