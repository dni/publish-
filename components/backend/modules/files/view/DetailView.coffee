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
    
    events:
      "click .delete": "deleteFile"
      
    deleteFile: ->
      @model.destroy
        success:->
      Vent.trigger 'app:closeRegion', 'contentRegion'