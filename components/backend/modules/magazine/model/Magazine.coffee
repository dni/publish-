define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Magazine extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "magazines"
    defaults:
      "_id": undefined
      "title": "Neues Magazine"
      "author": "default author"
      "desc": "description ..."
      "editorial": "Hello World!"
      "pages": ""
      "impressum": "dnilabs"
      "published": false
      "cover": ""
      "back": ""
      "papersize": "A4"
      "orientation": "horizontal"
      "files": []


    togglePublish: ->
      @.set "published", not @.get "published";
