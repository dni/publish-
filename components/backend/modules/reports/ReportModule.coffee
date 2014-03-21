define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/Collection'
    'cs!./controller/Controller'
    "text!./configuration.json"
],
( Marionette, Vent, Collection, Controller, Config ) ->


  Vent.on "app:ready", ()->

    Vent.trigger "app:addModule", JSON.parse Config
    App.Reports = new Collection
    App.Reports.fetch
      success:->


    App.Router.processAppRoutes new Controller,
      "reports": "list"
      "report/:id": "show"
      "": "dashboard"

    Vent.trigger "reports:ready"

