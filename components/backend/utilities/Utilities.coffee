define [
  'cs!utilities/Vent'
  'cs!utilities/Log'
  'cs!utilities/Debug'
  'cs!utilities/Viewhelpers'
  'cs!utilities/Date'
], ( Vent, Log, Debug, Viewhelpers) ->


  addSetting = (configname, settings, i18n)->
    Vent.trigger 'settings:addSetting', configname, settings, i18n

  settingsToAdd = []

  Vent.on 'settings:ready', ->
    while setting = settingsToAdd.pop()
      addSetting.apply @, setting

  # return utilites, date util extens Date Object
  Utilities =
    Viewhelpers: Viewhelpers
    Vent: Vent
    Log: Log
    Debug: Debug
    settingsready: false

    safeString: (str)->
      str.toLowerCase().split(" ").join("-")

    # addModule Shortcut
    addModule: (Config, i18n)->
      config = JSON.parse Config

      #add module setting
      if config.settings
        settingsToAdd.push [config.config.name, config.settings, i18n]

      # add module to navigation
      if config.navigation
        Vent.trigger 'publish:addNavItem', config.navigation, i18n

      # fire ready event for every module except settings
      if config.config.namespace != "settings"
        Vent.trigger config.config.namespace+":ready"


    isMobile: ()->
      userAgent = navigator.userAgent or navigator.vendor or window.opera
      return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))


  # Shortcut Log
  window.log = Log

  # Global c.l for console.log
  window.c = console
  c.l = c.log

  return Utilities