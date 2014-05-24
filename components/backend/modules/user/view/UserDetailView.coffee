define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'marionette'
  'tpl!../templates/detail.html'
  'cs!../model/User'
  'i18n!modules/user/nls/language.js'
], (App, Router, Utils, Marionette, Template, User, i18n) ->

  class UserDetailView extends Marionette.ItemView

    template: Template
    templateHelpers:
      t: i18n # translation
      vhs: Utils.Viewhelpers

    ui:
      name: '[name=name]'
      username: '[name=username]'
      email: '[name=email]'
      role: 'select'
      password: '[name=password]'

    events:
      "click .delete": "deleteModel"
      "click .cancel": "cancel"
      "click .save": "saveModel"

    cancel:->
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'

    deleteModel: ->
      Utils.Log i18n.deleteUser, 'delete', text: @model.get 'name'
      @model.destroy
        success:->
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'

    saveModel: ->
      @model.set
        name: @ui.name.val()
        username: @ui.username.val()
        email: @ui.email.val()
        role: @ui.role.val()
        password: @ui.password.val()

      if @model.isNew()
        App.Users.create @model,
          wait: true
          success: (res) ->
            route = 'user/'+res.attributes._id
            Utils.Log i18n.newUser, 'new',
              text: res.attributes.name
              href: route
            Router.navigate route, false
      else
        @model.save()
        Utils.Log i18n.updateUser, 'update',
          text: @model.get 'name'
          href: 'user/'+@model.get '_id'

