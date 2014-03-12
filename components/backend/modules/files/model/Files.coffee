define [
  "lodash"
  "backbone"
  "cs!./File"
],
(_, Backbone, File) ->
  class Files extends Backbone.Collection
    model: Files
    url: "/files/"
