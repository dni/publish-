define [
  'backbone'
], (Backbone) ->
  class Model extends Backbone.Model
    idAttribute: "_id"
    defaults:
      fields: {}

    # getValue: (fieldname)->
      # fields = @.get "fields"
      # if fields[fieldname]


    togglePublish: ->
      @.set "published", not @.get "published"

