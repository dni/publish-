define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
], (Vent, $, _, Backbone, Template) ->

  class DetailView extends Backbone.Marionette.ItemView

    template: Template

    deleteFile: ->
      @model.destroy
        success:->
      Vent.trigger 'app:closeRegion', 'contentRegion'

