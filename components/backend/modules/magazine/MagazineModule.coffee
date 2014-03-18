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
      "newMagazine": "addMagazine"
      "magazine/:id": "detailsMagazine"
      "magazines": "magazines"

    $("body").on "downloadApp", -> window.open(window.location.origin + '/downloadApp','_blank')

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