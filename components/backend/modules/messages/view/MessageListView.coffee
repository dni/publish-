define [
  'cs!App'
  'marionette'
  'cs!../model/Model'
  'tpl!../templates/list.html'
  'i18n!modules/messages/nls/language.js'
], (App, Marionette, Model, Template, i18n) ->

  class MessageListView extends Marionette.ItemView

    template: Template
    templateHelpers: t: i18n

    events:
      "submit form": "newMessage"
      "click [name='clear']": "clearMessages"
      "change [name=limit]": "limit"

    ui:
      message: '[name=message]'
      limit:  "[name=limit]"

    limit:->
      App.Messages.fetch
        data: limit: @ui.limit.val()

    #unused
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