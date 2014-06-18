define ['backbone'], (Backbone) ->
  class User extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "users"
    defaults:
      "_id": undefined
      "username": "noname"
      "name": "Noname"
      "email": "no@name.org"
      "role": "admin"
      "password": "******"
      "language": ""
