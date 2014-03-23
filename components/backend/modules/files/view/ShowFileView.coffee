define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/showfile.html'
  'cs!../model/File'
], (Vent, $, _, Backbone, Template, File) ->

  class ShowFileView extends Backbone.Marionette.ItemView

    template: Template

    ui:
      name: 'input[name=name]'
      info: 'textarea[name=info]'
      desc: 'textarea[name=desc]'
      key: 'input[name=key]'
      alt: 'input[name=alt]'

    events:
      "click .deleteFile": "deleteFile"
      "blur .form-control": "save"

    deleteFile: ->
      @model.destroy
        success:->

      $('.modal').modal('hide')

    save: ->
      @model.set
        name: @ui.name.val()
        info: @ui.info.val()
        alt: @ui.alt.val()
        desc: @ui.desc.val()
        key: @ui.key.val()
      @model.save()
