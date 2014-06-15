define ['backbone'], (Backbone) ->
  class Page extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "pages"
    defaults:
      "number": "0"
      "article": ""
      "layout": "default"
      "title": "noname"
      "magazine": ""
      "published": false

    togglePublish: ->
      @.set "published", not @.get "published"