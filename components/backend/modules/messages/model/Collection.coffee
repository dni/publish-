define [
  "lodash"
  "backbone"
  "cs!./Model"
], (_, Backbone, Model) ->
  class Messages extends Backbone.Collection
    model: Model
    url: "/messages/"
