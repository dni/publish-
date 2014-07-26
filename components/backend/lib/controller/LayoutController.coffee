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

    add: ->
      App.contentRegion.show new @Layout
        model: new @Model
        files: new @Collection
