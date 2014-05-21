define [
  'marionette'
  'tpl!../templates/list.html'
],
(Marionette, Template) ->
  class SettingsListTopView extends Marionette.ItemView
    template: Template