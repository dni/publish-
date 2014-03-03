define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Setting extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "settings"