define [
  'cs!utils'
  'marionette'
  'io'
], ( Utils, Marionette, io ) ->

  App.addInitializer ->
    socket = io.connect()

    # socket.on "connect", ->
      # SocketAdapter.connected = true
      # App.vent.trigger "socket:connected"

    socket.on "updateCollection", (collection)->
      c.l "updatecollection", collection
      App[collection].fetch
        success:->

    # socket.on "disconnect", ->
      # SocketAdapter.connected = false
      # App.vent.trigger "socket:disconnected"

    socket.on "error", (err)->
      Utils.Log "SOCKET ERROR: " + err