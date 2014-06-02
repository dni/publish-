define [
  'cs!App'
  'cs!modules/messages/model/Model'
], (App, Message) ->
  (log, type, additionalinfo)->
    if !additionalinfo? then additionalinfo = ''
    if !type? then type = 'log'
    message = new Message
    message.set
      message: log
      username: App.User.get "name"
      date: new Date()
      type: type
      additionalinfo: additionalinfo

    App.Messages.create message,
      success: ->

    console.log message
    message