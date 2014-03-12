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
      "cover": ""
      "back": ""
