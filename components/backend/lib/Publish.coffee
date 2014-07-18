define [
  'cs!utils'
  'cs!lib/controller/Controller'
  'cs!lib/Module'
  'cs!lib/model/Model'
  'cs!lib/model/Collection'
  'cs!lib/view/ListView'
  'cs!lib/view/DetailView'
  'cs!lib/view/EmptyView'
  'cs!lib/view/TopView'
  'cs!lib/Regions'
  'cs!lib/Events'
  'cs!lib/Socket'
], ( Utils, Controller, Module, Model, Collection, ListView, DetailView, EmptyView, TopView) ->
  Utils: Utils
  Module: Module
  Controller: Controller
  Model: Model
  Collection: Collection
  View:
    EmptyView: EmptyView
    TopView: TopView
    ListView: ListView
    DetailView: DetailView