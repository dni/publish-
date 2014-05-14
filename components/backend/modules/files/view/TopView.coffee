define [
  'marionette'
  'tpl!../templates/top.html'
], (Marionette, Template) ->
  class TopView extends Marionette.ItemView
    template: Template
    events:
      "change #upload": "uploadFile"

    uploadFile: ->
      @$el.find("#uploadFile").ajaxForm (response) ->
      @$el.find("#uploadFile").submit()

