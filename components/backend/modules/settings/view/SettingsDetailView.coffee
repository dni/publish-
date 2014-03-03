define ['jquery', 'lodash', 'backbone', 'tpl!../templates/detail.html'], ( $, _, Backbone, Template) ->

  class SettingsDetailView extends Backbone.Marionette.ItemView
    
    template: Template

    initialize: ->
      @model.bind 'change', @render, @    

    ui:
      save: ".save"
      cancel: ".cancel"
  
    events:
      "click .save": "save"

    save: ->
      @model.set
        name: "savedModule"
        
      # @model.save()
