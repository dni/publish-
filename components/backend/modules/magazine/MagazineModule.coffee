define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/Magazines'
    'cs!./controller/MagazineController'
    "text!./configuration.json"
],
( Marionette, Vent, Magazines, Controller, Config ) ->

  Vent.on "app:ready", ()->
    Vent.trigger "app:addModule", JSON.parse Config
    App.Magazines = new Magazines
    App.Magazines.fetch
      success:->
    App.Router.processAppRoutes new Controller,
      "magazines": "list"
      "magazine/:id": "details"
      "newMagazine": "add"
    Vent.trigger "magazine:ready"
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