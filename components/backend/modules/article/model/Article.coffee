define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Article extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "articles"
    defaults:
      "_id": undefined
      "title": "Neuer Artikel"
      "desc": "Hello World!"
      "files": []
      "author": "dnilabs"
      "privatecode": true

    togglePublish: ->
      @.set "privatecode", not @.get "privatecode";

