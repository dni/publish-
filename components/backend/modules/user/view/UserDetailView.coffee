define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
  'cs!../model/User'
], (Vent, $, _, Backbone, Template, User) ->

  class UserDetailView extends Backbone.Marionette.ItemView

    template: Template

    events:
      "click .delete": "deleteModel"
      "blur .form-control": "saveModel"

    deleteModel: ->
      @model.destroy
        success:->
      Vent.trigger 'app:closeRegion', 'contentRegion'

    saveModel: ->
      @model.set
        name: @$el.find("input[name=name]").val()
        role: @$el.find("select").val()
        password: @$el.find("input[name=password]").val()
      if @model.isNew()
        App.Users.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'user/'+res.attributes._id, false
      else
        @model.save()

