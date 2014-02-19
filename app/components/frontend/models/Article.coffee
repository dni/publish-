define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Article extends Backbone.Model
    idAttribute: "_id"
