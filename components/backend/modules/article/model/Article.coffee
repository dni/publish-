define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Article extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "articles"
    defaults:
      "title": "Neuer Artikel"
      "desc": "Hello World!"
      "images": ""
      "author": "dnilabs"
      "privatecode": true

    togglePublish: ->
      @.set "privatecode", not @.get "privatecode";

