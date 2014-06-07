define [
  "backbone"
  "cs!modules/settings/model/Setting"
],
(Backbone, Model) ->

  class Settings extends Backbone.Collection
    model: Model
    url:"/settings/"

  return new Settings
