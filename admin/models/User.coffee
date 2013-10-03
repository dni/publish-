define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class User extends Backbone.Model
    defaults:
      "name": "Yeoman Hermann"
      "email": "y@hermann.com"
      "passwort": ""