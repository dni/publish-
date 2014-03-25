define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/cropfile.html'
  'cs!../model/File'
], (Vent, $, _, Backbone, Template, File) ->

  class CropFileView extends Backbone.Marionette.ItemView

    template: Template

    ui:
      name: 'input[name=name]'

    events:
      "blur .form-control": "save"

    save: ->
      @model.set
        name: @ui.name.val()
        info: @ui.info.val()
        alt: @ui.alt.val()
        desc: @ui.desc.val()
        key: @ui.key.val()
      @model.save()
