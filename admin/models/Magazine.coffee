define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Magazine extends Backbone.Model
    idAttribute: "_id"
    defaults:
      "title": "Neues Magazine"
      "editorial": "Hello World!"
      "pages": ""
      "impressum": "dnilabs"
      "cover": ""
      "back": ""
