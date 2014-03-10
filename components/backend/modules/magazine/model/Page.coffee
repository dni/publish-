define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Page extends Backbone.Model
    defaults:
      "number": 0
      "article": ""
      "layout": ""
    initialize: (attributes, options)->
      #if not @.get("number") then @.set("number", (Math.random()*255)>>0)
