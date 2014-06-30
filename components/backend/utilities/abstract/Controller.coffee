define [
  'cs!App'
  'cs!Publish'
  'marionette'
], ( App, Publish, Marionette) ->
  class Controller extends Marionette.Controller

    settings: (attr)->
      (App.Settings.findWhere name: @moduleName).getValue(attr)

    details: (id) ->
      model = App[@Config.collectionName].findWhere _id: id
      if model
         view = new @DetailView model: model
      else
        view = new Publish.Views.EmptyView message: @i18n.emptyMessage
      App.contentRegion.show view

    add: ->
      App.contentRegion.show new @DetailView
        model: new @Model

    show: ->
      App.listTopRegion.show new Publish.Views.TopView
        navigation: @i18n.navigation
        newRoute: 'new'+@Config.moduleName
      App.listRegion.show new @ListView collection: App[@Config.collectionName]

