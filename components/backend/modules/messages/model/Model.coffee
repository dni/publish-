define [
  'jquery'
  'lodash'
  'backbone'
], ($, _, Backbone) ->
  class Message extends Backbone.Model
    idAttribute: "_id"
