define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
  'cs!../model/StaticBlock'
], (Vent, $, _, Backbone, Template, StaticBlock) ->

  class StaticDetailView extends Backbone.Marionette.ItemView

    template: Template

    ui:
      edit: ".edit"
      key: 'input[name=key]'
      data: 'textarea[name=data]'

    events:
      "click .save": "saveStatic"
      "click .delete": "deleteStatic"

    addFiles:->
      App.Router.navigate "filebrowser", true

    toggleEdit: ->
      #@ui.edit.toggle()
      #@ui.preview.toggle()

    saveStatic: ->
      @model.set
        key: @ui.key.val()
        data: @ui.data.val()
      if @model.isNew()
        App.StaticBlocks.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'static/'+res.attributes._id, false
      else
        @model.save()
      @toggleEdit()

    deleteStatic: ->
      @model.destroy
        success:->
      Vent.trigger 'app:closeRegion', 'contentRegion'
