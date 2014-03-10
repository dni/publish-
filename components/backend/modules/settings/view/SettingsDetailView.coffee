define ['jquery', 'lodash', 'backbone', 'tpl!../templates/detail.html'], ( $, _, Backbone, Template) ->

  class SettingsDetailView extends Backbone.Marionette.ItemView
    
    template: Template

    initialize: ->
      @model.bind 'change', @render, @    

    ui:
      save: ".save"
      cancel: ".cancel"
  
    events:
      "blur input": "save"

    save: ->
      settings = @model.get "settings"
      @$el.find(".form-group").each ()->
        input = $(@).find "input"
        console.log input.is(':checked')
        if input.attr("type") == ("checkbox" or "radio") then val = input.is(':checked')
        else val = input.val()
        settings[input.attr("name")].value = val
        
      @model.set settings: settings
      @model.save()
