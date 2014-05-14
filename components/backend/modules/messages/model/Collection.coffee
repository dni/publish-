define [
  "lodash"
  "backbone"
  "cs!modules/messages/model/Model"
], (_, Backbone, Model) ->
  class Messages extends Backbone.Collection
    model: Model
    url: "/messages/"
