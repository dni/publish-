define [
  "backbone"
  "cs!./Setting"
],
(Backbone, Model) ->

  class Settings extends Backbone.Collection
    model: Model
    url:"/settings/"
