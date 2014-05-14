define [
  "backbone"
  "cs!./File"
], (Backbone, File) ->
  class Files extends Backbone.Collection
    model: File
    url: "/files/"
