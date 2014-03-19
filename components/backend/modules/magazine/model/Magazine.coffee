define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Magazine extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "magazines"
    defaults:
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

    togglePublish: ->
      @.set "published", not @.get "published";
