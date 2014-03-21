define [
  "lodash"
  "backbone"
  "cs!./Model"
], (_, Backbone, Model) ->
  class Reports extends Backbone.Collection
    model: Model
    url: "/reports/"
