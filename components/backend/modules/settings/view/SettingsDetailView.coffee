define ['jquery', 'lodash', 'backbone', 'tpl!../templates/detail.html'], ( $, _, Backbone, Template) ->

  class SettingsDetailView extends Backbone.Marionette.ItemView

    template: Template

    initialize: ->
      # @model.bind 'change', @render, @

    ui:
      save: ".save"
      cancel: ".cancel"

    events:
      "change .setting": "save"

    save: ->
      settings = @model.get "settings"

      @$el.find(".setting").each ()->
        type = $(@).attr("type")
        if type == ("checkbox" or "radio") then val = $(@).is(':checked')
        else val = $(@).val()
        settings[$(@).attr("name")].value = val

      @$el.find(".colorpicker").each ()->
        settings[$(@).attr("name")].value = $(@).val()
        c.l settings[$(@).attr("name")]

      @model.set 'settings', settings
      @model.save()
