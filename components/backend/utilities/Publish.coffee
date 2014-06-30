define [
  'cs!utils'
  'cs!utilities/abstract/Controller'
  'cs!utilities/abstract/Model'
  'cs!utilities/abstract/Collection'
  'cs!utilities/abstract/views/EmptyView'
  'cs!utilities/abstract/views/TopView'
], ( Utils, Controller, Model, Collection, EmptyView, TopView) ->
  Publish =
    Utils: Utils
    Controller: Controller
    Model: Model
    Collection: Collection
    Views:
      EmptyView: EmptyView
      TopView: TopView