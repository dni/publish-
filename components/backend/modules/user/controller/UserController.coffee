define [
  'cs!App'
  'cs!utils'
  'i18n!modules/user/nls/language.js'
  'marionette'
  'cs!../view/UserListView'
  'cs!../view/UserDetailView'
  'cs!../model/User'
  'cs!utilities/views/TopView'
  'cs!utilities/views/EmptyView'
], ( App, Utils, i18n, Marionette, UserListView, UserDetailView, User, TopView, EmptyView ) ->

  class UserController extends Marionette.Controller

    logout: ->
      if confirm i18n.confirmLogout then window.location = window.location.origin + '/logout'

    details: (id) ->
      user = App.Users.where _id: id
      if user then view = new UserDetailView model: user[0]
      else view = new EmptyView message: i18n.emptyMessage
      Utils.Vent.trigger 'app:updateRegion', "contentRegion", view

    add: ->
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', new UserDetailView model:new User

    list: ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView navigation: i18n.navigation, newModel: 'newUser'
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new UserListView collection: App.Users