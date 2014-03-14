define [
  'jquery'
  'lodash'
  'backbone'
], ($, _, Backbone) ->
  class File extends Backbone.Model
    defaults:
      "name": "file.txt"
      "link": "/file.txt"
      "type": "txt"
    #initialize: (attributes, options)->
      #null
      #if not @.get("number") then @.set("number", (Math.random()*255)>>0)
