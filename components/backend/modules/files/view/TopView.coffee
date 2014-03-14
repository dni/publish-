define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!../templates/top.html'
],
($, _, Backbone, Marionette, Template) ->
  class TopView extends Backbone.Marionette.ItemView
    template: Template

    events:
      "change #upload": "uploadFile"

    uploadFile: ->
      @$el.find("#uploadFile").submit()
