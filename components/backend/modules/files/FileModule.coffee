define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/Files'
    'cs!./controller/FileController'
    "text!./configuration.json"
],
( Marionette, Vent, Files, Controller, Config ) ->


  Vent.on "app:ready", ()->
    Vent.trigger "app:addModule", JSON.parse Config
    App.Files = new Files
    App.Files.fetch
      success:->
    App.Router.processAppRoutes new Controller,
      "newFile": "addFile"

    #$("body").on "downloadApp", -> window.open(window.location.origin + '/downloadApp','_blank')

    Vent.trigger "files:ready"
#
  # module = {
    # name: "MagazineModule"
    # namespace: "magazine"
    # config: JSON.parse Config
  # }
#
  # Command.setHandler "app:ready", ()->
    # App.Magazines = new Magazines
    # App.Magazines.fetch
      # success:->
    # App.MagazineRouter = new Router
    # Command.execute "app:addModule", module