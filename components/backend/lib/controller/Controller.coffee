define [
  'cs!App'
  'marionette'
  "cs!../model/Model"
  "cs!../model/Collection"
  "cs!../view/EmptyView"
  "cs!../view/TopView"
  "cs!../view/ListView"
  "cs!../view/DetailView"

], ( App, Marionette, Model, Collection, EmptyView, TopView, ListView, DetailView) ->
  class Controller extends Marionette.Controller

    constructor: (args)->
      @[key] = arg for key, arg of args
      unless @Model? then @Model = Model
      unless @Collection? then @Collection = Collection
      unless @DetailView? then @DetailView = DetailView
      unless @ListView? then @ListView = ListView
      unless @TopView? then @TopView = TopView
      unless @EmptyView? then @EmptyView = EmptyView

    defaults: ->
      defaults = {}
      return defaults[key] = '' for key, data in @Config.model

    settings: (attr)->
      (App.Settings.findWhere name: @Config.moduleName).getValue(attr)

    details: (id) ->
      model = App[@Config.collectionName].findWhere _id: id
      if model
        view = new @DetailView model: model
      else
        view = new @EmptyView message: @i18n.emptyMessage
      App.contentRegion.show view

    add: ->
      model = new @Model
        defaults: @defaults()
      model.urlRoot = @Config.urlRoot
      model.modelName = @Config.modelName

      App.contentRegion.show new @DetailView
        model: model

    list: ->
      App.listTopRegion.show new @TopView
        navigation: @i18n.navigation
        newRoute: 'new'+@Config.modelName
      App.listRegion.show new @ListView collection: App[@Config.collectionName]

