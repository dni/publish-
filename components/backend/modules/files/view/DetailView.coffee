define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
  'cs!../model/File'
], (Vent, $, _, Backbone, Template, File) ->

  class DetailView extends Backbone.Marionette.ItemView

    template: Template

    initialize: ->
      @model.on "change", @render

    ui:
      name: 'input[name=name]'
      info: 'textarea[name=info]'
      desc: 'textarea[name=desc]'
      alt: 'input[name=alt]'


    events:
      "click .delete": "deleteFile"
      "click .rename": "save"

    deleteFile: ->
      @model.destroy
        success:->
      Vent.trigger 'app:closeRegion', 'contentRegion'

    save: ->
      @model.set
        name: @ui.name.val()
        info: @ui.info.val()
        alt: @ui.alt.val()
        desc: @ui.desc.val()
      @model.save()
