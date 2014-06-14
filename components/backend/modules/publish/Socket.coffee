define [
  'cs!App'
  'cs!utils'
  'io'
], (App, Utils, io ) ->

  socket = io.connect()

  socket.on "updateCollection", (collection)->
    App[collection].fetch
      success:->

  socket.on "disconnect", ->
    # reload page for new login after server restarts/crashed
    reload = -> document.location.reload()
    setTimeout reload, 3000


  socket.on "error", (err)->
    Utils.Log "SOCKET ERROR: " + err