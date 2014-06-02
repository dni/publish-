define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'i18n!../nls/language.js'
  'jquery'
  'marionette'
  'tpl!../templates/detail.html'
], ( App, Router, Utils, i18n, $, Marionette, Template) ->

  class SettingsDetailView extends Marionette.ItemView

    template: Template

    reset:->
      Utils.Log i18n.deleteSetting, 'delete',
        text: @model.get 'name'
        href: 'setting/'+@model.get 'name'

      @model.destroy
        success:->
      App.contentRegion.close()
      Router.navigate 'settings'

    save: ->
      Utils.Log i18n.updateSetting, 'update',
        text: @model.get 'name'
        href: 'setting/'+@model.get 'name'


      settings = @model.get "settings"
      @$el.find(".setting").each ()->
        type = $(@).attr("type")
        if type=="checkbox" or type=="radio" then val = $(@).is(':checked')
        else val = $(@).val()
        settings[$(@).attr("name")].value = val

      @model.set 'settings', settings
      @model.save()