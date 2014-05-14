define [
  'cs!utilities/Vent'
  'cs!utilities/Log'
], ( Vent, Log ) ->
  # return utilites, date util extens Date Object
  Utilities =

    Vent: Vent
    Log: Log

    # addModule Shortcut
    addModule: (Config)->
      Vent.trigger "app:addModule", JSON.parse Config

    isMobile: ()->
      userAgent = navigator.userAgent or navigator.vendor or window.opera
      return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))


  # Shortcut Log
  window.log = Log;

  # Global c.l for console.log
  window.c = console; c.l = c.log

  return Utilities