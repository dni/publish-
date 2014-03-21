define [
  'jquery'
  'lodash'
  'backbone'
], ($, _, Backbone) ->
  class Report extends Backbone.Model
    idAttribute: "_id"
