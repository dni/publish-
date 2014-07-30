define [
  'cs!App'
  'cs!./model/Model'
  'cs!utils'
  'io'
], (App, Model, Utils, io ) ->
  socket = io()
  socket.set("close timeout", 30);
  socket.set("heartbeat interval", 30);
  socket.on "message", (msg)->
    msgType = ""
    msgText = msg.username+" "+msg.message
    if msg.type is "update" or msg.type is "message" then msgType = "info"
    else if msg.type is "delete" then msgType = "warn"
    else if msg.type is "new" then msgType = "success"
    #else if msgType is "update" then msgType = "error"
    $.notify msgText,
      className: msgType
      position:"right bottom"

  socket.on "updateCollection", (collection)->
    App[collection].fetch
      success:->

  socket.on "disconnect", ->
    # reload page for new login after server restarts/crashed
    reload = -> document.location.reload()
    setTimeout reload, 3000

  socket.on "connect", ->
    # reload page for new login after server restarts/crashed
    $.get "/user", (user)->
      console.log "user"
      App.User = new Model user

  socket.on "error", (err)->
    Utils.Log "SOCKET ERROR: " + err
