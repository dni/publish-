define [
  'backbone'
], (Backbone) ->
  class File extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "files"
    defaults:
      "info": ""
      "alt": ""
      "desc": ""
      "key": ""
