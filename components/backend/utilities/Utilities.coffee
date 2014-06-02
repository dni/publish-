define [
  'cs!utilities/Vent'
  'cs!utilities/Log'
  'cs!utilities/Viewhelpers'
  'cs!utilities/Date'
], ( Vent, Log, Viewhelpers) ->


  addSetting = (configname, settings, i18n)-> Vent.trigger 'settings:addSetting', configname, settings, i18n

  isReady = false
  settingsToAdd = []

  Vent.on 'settings:ready', ->
    isReady = true
    while setting = settingsToAdd.pop()
      addSetting.apply @, setting

  # return utilites, date util extens Date Object
  Utilities =
    Viewhelpers: Viewhelpers
    Vent: Vent
    Log: Log
    settingsready: false

    # addModule Shortcut
    addModule: (Config, i18n)->
      config = JSON.parse Config

      #add module setting
      if config.settings
        if isReady then addSetting config.config.name, config.settings, i18n
        else settingsToAdd.push [config.config.name, config.settings, i18n]

      # add module to navigation
      if config.navigation then Vent.trigger 'publish:addNavItem', config.navigation, i18n

      # fire ready event for every module except settings
      if config.config.namespace != "settings" then Vent.trigger config.config.namespace+":ready"


    isMobile: ()->
      userAgent = navigator.userAgent or navigator.vendor or window.opera
      return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))


  # Shortcut Log
  window.log = Log

  # Global c.l for console.log
  window.c = console
  c.l = c.log

  return Utilities