define [
  'backbone'
], (Backbone) ->
  class Model extends Backbone.Model
    idAttribute: "_id"
    togglePublish: ->
      @.set "published", not @.get "published"

