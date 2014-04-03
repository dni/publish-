define [
    'marionette'
    'cs!../../utilities/Vent'
    "text!./configuration.json"
],
( Marionette, Vent, Config ) ->
  Vent.on "app:ready", ()->
    Vent.trigger "app:addModule", JSON.parse Config
    $("body").on "downloadApp", -> window.open(window.location.origin + '/downloadApp','_blank')
    Vent.trigger "baker:ready"