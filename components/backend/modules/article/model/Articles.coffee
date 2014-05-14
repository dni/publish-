define [
  "backbone"
  "cs!./Article"
], (Backbone, Model) ->
  class Articles extends Backbone.Collection
    model: Model
    url: "/articles/"