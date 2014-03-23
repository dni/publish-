define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Page extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "magazines"
    defaults:
      "number": "0"
      "article": ""
      "layout": "default"
    initialize: (attributes, options)->
      #if not @.get("number") then @.set("number", (Math.random()*255)>>0)
