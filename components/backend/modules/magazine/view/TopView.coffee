define [
  'marionette'
  'tpl!../templates/top.html'
], (Marionette, Template) ->
  class TopView extends Marionette.ItemView
    template: Template
