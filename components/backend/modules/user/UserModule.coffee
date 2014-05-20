define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'jquery'
  'marionette'
  'cs!./model/Users'
  'cs!./controller/UserController'
  "text!./configuration.json"
], ( App, Router, Utils, $, Marionette, Users, Controller, Config ) ->

  App.Users = new Users
  App.Users.fetch
    success:->
      $.get '/user', (user) ->
        App.User = App.Users.findWhere _id:user.id


  Router.processAppRoutes new Controller,
    "users": "list"
    "logout": "logout"
    "user/:id": "details"
    "newUser": "add"

  Utils.addModule Config
