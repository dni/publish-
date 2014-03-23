define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Page extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "pages"
    defaults:
      "number": "0"
      "article": ""
      "layout": "default"
