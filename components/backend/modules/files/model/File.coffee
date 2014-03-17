define [
  'jquery'
  'lodash'
  'backbone'
], ($, _, Backbone) ->
  class File extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "files"
    defaults:
      "info": ""
      "alt": ""
      "desc": ""
