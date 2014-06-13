define [
  "backbone"
  "cs!utils"
  "cs!modules/settings/model/Setting"
],
(Backbone, Utils, Model) ->

  class Settings extends Backbone.Collection
    model: Model
    url:"/settings/"

