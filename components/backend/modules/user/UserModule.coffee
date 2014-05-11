define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/Users'
    'cs!./controller/UserController'
    "text!./configuration.json"
], ( Marionette, Vent, Users, Controller, Config ) ->

  Vent.on "app:ready", ()->
    Vent.trigger "app:addModule", JSON.parse Config


    App.Users = new Users
    App.Users.fetch
      success:->
        $.get '/user', (user) ->
          App.User = App.Users.findWhere _id:user.id


    App.Router.processAppRoutes new Controller,
      "users": "list"
      "logout": "logout"
      "user/:id": "details"
      "newUser": "add"
    Vent.trigger "user:ready"
