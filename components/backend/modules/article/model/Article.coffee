define [
  'backbone'
], (Backbone) ->
  class Article extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "articles"
    defaults:
      "_id": undefined
      "title": "Neuer Artikel"
      "desc": "Hello World!"
      "files": []
      "author": "dnilabs"
      "published": false
      "category": ""
      "tags": ""

    togglePublish: ->
      @.set "published", not @.get "published"

