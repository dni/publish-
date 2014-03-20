define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!../templates/top.html'
  "jquery.form"
  'cs!../view/ListView'

],
($, _, Backbone, Marionette, Template) ->
  class TopView extends Backbone.Marionette.ItemView
    template: Template

    events:
      "change #upload": "uploadFile"

    uploadFile: ->
      @$el.find("#uploadFile").ajaxForm (response) ->
        App.Files.fetch()

      @$el.find("#uploadFile").submit()

