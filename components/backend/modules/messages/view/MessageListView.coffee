define [
  'jquery'
  'lodash'
  'backbone'
  'cs!../model/Model'
  'tpl!../templates/list.html'
  # 'i18n!../nls/language.js'
], ($, _, Backbone, Model, Template, i18n) ->

  class MessageListView extends Backbone.Marionette.ItemView

    template: Template
    templateHelpers: t: i18n

    events:
      "submit form": "newMessage"
      "click [name='clear']": "clearMessages"

    ui:
      message: '[name=message]'

    clearMessages: ->
      messages = App.Messages.models
      if confirm i18n.confirmClear
        while model = App.Messages.first()
          model.destroy()

    newMessage: (e)->
      e.preventDefault()

      # do nothing on empty message
      if not @ui.message.val() then return

      message = new Model
      message.set
        message: @ui.message.val()
        username: App.User.get "name"
        date: new Date()
        type: 'message'

      @ui.message.val('')

      App.Messages.create message,
        success: (res) ->

      return false