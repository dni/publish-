define [
  'cs!App'
  'cs!utils'
  'marionette'
  'cs!../view/UserListView'
  'cs!../view/UserDetailView'
  'cs!../model/User'
  'cs!../view/TopView'
], ( App, Utils, Marionette, UserListView, UserDetailView, User, TopView ) ->

  class UserController extends Marionette.Controller

    logout: ->
      if confirm 'Logout?' then window.location = window.location.origin + '/logout'

    settings: ->
      App.Settings.where({name: "UserModule"})[0]

    details: (id) ->
      user = App.Users.where _id: id
      Utils.Vent.trigger 'app:updateRegion', "contentRegion", new UserDetailView model: user[0]

    add: ->
      view = new UserDetailView model:new User
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', view

    list: ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new UserListView collection: App.Users