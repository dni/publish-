define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Category extends Backbone.Model
    defaults: 
      "title": "Neue Kategorie"
      "parent": 0
