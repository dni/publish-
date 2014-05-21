define [
  'cs!utils'
  'marionette'
  'tpl!../templates/detail.html'
], (Utils, Marionette, Template) ->

  class DetailView extends Marionette.ItemView

    template: Template

    ui:
      name: 'input[name=name]'
      info: 'textarea[name=info]'
      desc: 'textarea[name=desc]'
      alt: 'input[name=alt]'

    events:
      "click .delete": "deleteFile"
      "blur .form-control": "save"

    deleteFile: ->
      @model.destroy
        success:->
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'

    save: ->
      @model.set
        name: @ui.name.val()
        info: @ui.info.val()
        alt: @ui.alt.val()
        desc: @ui.desc.val()
      @model.save()
