define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'marionette'
  'tpl!../templates/detail.html'
  'cs!../model/User'
], (App, Router, Utils, Marionette, Template, User) ->

  class UserDetailView extends Marionette.ItemView

    template: Template

    events:
      "click .delete": "deleteModel"
      "blur .form-control": "saveModel"

    deleteModel: ->
      @model.destroy
        success:->
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'

    saveModel: ->
      @model.set
        name: @$el.find("input[name=name]").val()
        role: @$el.find("select").val()
        password: @$el.find("input[name=password]").val()
      if @model.isNew()
        App.Users.create @model,
          wait: true
          success: (res) ->
            Router.navigate 'user/'+res.attributes._id, false
      else
        @model.save()

