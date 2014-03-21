define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/message.html'
], ($, _, Backbone, Template) ->
  class MessageView extends Backbone.Marionette.ItemView
    template: Template