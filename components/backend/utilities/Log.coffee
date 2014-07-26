define [
  'cs!App'
  'cs!lib/model/Model'
  'notifyjs'
  'jquery'
], (App, Model, notify, $) ->
  (log, type, additionalinfo)->
    if !additionalinfo? then additionalinfo = ''
    if !type? then type = 'log'
    message = new Model
    message.set
      message: log
      username: App.User.get "name"
      date: new Date()
      type: type
      additionalinfo: additionalinfo

    App.Messages.create message,
      success: ->

    message
