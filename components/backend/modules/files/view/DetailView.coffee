define [
  'cs!utils'
  'marionette'
  'tpl!../templates/detail.html'
  'i18n!modules/files/nls/language.js'
], (Utils, Marionette, Template, i18n) ->

  class DetailView extends Marionette.ItemView

    template: Template
    templateHelpers: t: i18n # translation

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
      Utils.Log i18n.deleteFile, 'update', text: @model.get 'name'
      Utils.Vent.trigger 'app:closeRegion', 'contentRegion'

    save: ->
      @model.set
        name: @ui.name.val()
        info: @ui.info.val()
        alt: @ui.alt.val()
        desc: @ui.desc.val()
      @model.save()

      Utils.Log i18n.updateFile, 'update',
        text: @model.get 'name'
        href: 'file/'+@model.get '_id'
