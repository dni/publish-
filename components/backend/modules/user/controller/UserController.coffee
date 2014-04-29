define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/UserListView'
  'cs!../view/UserDetailView'
  'cs!../model/User'
  'cs!../view/TopView'
], ( Vent, $, _, Backbone, Marionette, UserListView, UserDetailView, User, TopView ) ->

  class UserController extends Backbone.Marionette.Controller

    logout: ->
      window.location = window.location.origin + '/logout'

    settings: ->
      App.Settings.where({name: "UserModule"})[0]

    details: (id) ->
      user = App.Users.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new UserDetailView model: user[0]

    add: ->
      view = new UserDetailView model:new User
      Vent.trigger 'app:updateRegion', 'contentRegion', view

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new UserListView collection: App.Users