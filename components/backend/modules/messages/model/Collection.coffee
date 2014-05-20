define [
  "backbone"
  "cs!modules/messages/model/Model"
], (Backbone, Model) ->
  class Messages extends Backbone.Collection
    model: Model
    url: "/messages/"
