define [
  'jquery'
  'lodash'
  'backbone'
], ($, _, Backbone) ->
  class Message extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "messages"
    defaults:
      additionalinfo:
        href: ''
        text: ''
