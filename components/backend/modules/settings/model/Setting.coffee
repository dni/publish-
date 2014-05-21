define [
  'backbone'
], (Backbone) ->
  class Setting extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "settings"

    getValue:(val)->
      @.get("settings")[val].value
