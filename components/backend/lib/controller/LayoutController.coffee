define [
  'cs!App'
  'marionette'
  "cs!../view/Layout"
  "cs!../model/Collection"
  "cs!../view/EmptyView"
  "cs!../view/TopView"
  "cs!../view/ListView"
  "cs!../view/DetailView"

], ( App, Marionette, Model, Collection, EmptyView, TopView, ListView, DetailView) ->
  class LayoutController extends Publish.Controller

    constructor: (args)->
      unless args.Layout? then @Layout = Layout
      super args

    details: (id) ->
      model = App[@Config.collectionName].findWhere _id: id
      if model
        view = @newDetailView model
      else
        view = new @EmptyView message: @i18n.emptyMessage

      App.contentRegion.show view

    add: ->
      fields = {}
      for key, field of @Config.model
        fields[key] =
          value: ''
          type: field.type

      model = new @Model

      model.set
        fields: fields
        name: @Config.modelName

      model.urlRoot = @Config.urlRoot
      model.collectionName = @Config.collectionName
      App.contentRegion.show @newDetailView model