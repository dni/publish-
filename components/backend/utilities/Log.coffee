define [
  'cs!modules/messages/model/Model'
],
(Message) ->
  (log, type, additionalinfo)->
    if additionalinfo? else additionalinfo = ''
    if type? else type = 'log'
    # message = new Message
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