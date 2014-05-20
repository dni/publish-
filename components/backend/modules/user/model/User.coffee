define ['backbone'], (Backbone) ->
  class User extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "users"
    defaults:
      "_id": undefined
      "name": "gues"
      "role": "guest"
      "password": "hackme"

    getPw: ->
      @.get("password")

