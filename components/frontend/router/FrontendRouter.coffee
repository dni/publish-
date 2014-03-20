define [
    'jquery',
    'lodash',
    'backbone',
    'cs!view/ListView',
    'cs!view/DetailView',
],
( $, _, Backbone, ListView, DetailView ) ->
  class FrontendRouter extends Backbone.Router

    routes:
      "": "list",
      "article/:id": "details"

    list: ->
      App.contentRegion.show new ListView collection: App.Articles

    details: (id) ->
      model = App.Articles.where _id: id
      App.contentRegion.show new DetailView model: model[0]
