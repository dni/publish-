define [
  'cs!App'
  'cs!modules/messages/model/Model'
  'notifyjs'
  'jquery'
], (App, Message, notify, $) ->
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

    msgType = message.attributes.type
    msg = message.attributes.username+" "+message.attributes.message
    if msgType is "update" or msgType is "update" then msgType = "info"
    else if msgType is "delete" then msgType = "warn"
    else if msgType is "new" then msgType = "success"
    #else if msgType is "update" then msgType = "error"
    $.notify msg, msgType

    message