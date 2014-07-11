define [
  'Publish'
], (Publish) ->
  class UserController extends Publish.Controller

    routes:
      "logout": "logout"

    logout: ->
      if confirm @i18n.confirmLogout then window.location = window.location.origin + '/logout'