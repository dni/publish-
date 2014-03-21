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
    App.Router.processAppRoutes new Controller,
      "users": "list"
      "user/:id": "details"
      "newUser": "add"
    Vent.trigger "user:ready"
