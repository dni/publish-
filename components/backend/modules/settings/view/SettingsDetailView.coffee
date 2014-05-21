define [
  'cs!utils'
  'jquery'
  'marionette'
  'tpl!../templates/detail.html'
], ( Utils, $, Marionette, Template) ->

  class SettingsDetailView extends Marionette.ItemView

    template: Template

    initialize: ->
      # @model.bind 'change', @render, @

    reset:->
      console.log "resets"
      @model.destroy success:->
        document.location.reload()

    save: ->
      settings = @model.get "settings"
      @$el.find(".setting").each ()->
        type = $(@).attr("type")
        if type=="checkbox" or type=="radio" then val = $(@).is(':checked')
        else val = $(@).val()
        settings[$(@).attr("name")].value = val

      @model.set 'settings', settings
      @model.save()
