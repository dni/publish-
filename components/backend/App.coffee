define (require)->

  $ = require 'jquery'
  _ = require 'lodash'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  io = require 'io'
  Setting = require 'cs!./modules/settings/model/Setting'
  Settings = require 'cs!./modules/settings/model/Settings'
  NavItems = require 'cs!./model/NavItems'
  NavItem = require 'cs!./model/NavItem'
  NavigationView = require 'cs!./view/NavigationView'
  AppRouter = require 'cs!./router/AppRouter'
  Less = require 'less!./style/main.less'
  Config = require 'text!./configuration/mainConfiguration.json'
  Bootstrap = require "bootstrap"
  tinyMCE = require "tinymce"
  tinyMCEjquery = require "jquery.tinymce"
  minicolor = require "minicolors"

  isMobile = ()->
    userAgent = navigator.userAgent or navigator.vendor or window.opera
    return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))


  App = new Backbone.Marionette.Application

  App.Utilities = {
    Date: require "cs!./utilities/Date"
    Vent: require "cs!./utilities/Vent"
    Log: require "cs!./utilities/Log"
  }
  # Shortcut Log
  window.log = App.Utilities.Log;

  # Global c.l for console.log
  window.c = console; c.l = c.log

  # socket
  App.addInitializer ->
    socket = io.connect()
    # socket.on "connect", ->
      # SocketAdapter.connected = true
      # App.vent.trigger "socket:connected"

    socket.on "updateCollection", (collection)->
      App[collection].fetch()

    # socket.on "disconnect", ->
      # SocketAdapter.connected = false
      # App.vent.trigger "socket:disconnected"

    socket.on "error", (err)->
      c.l "SOCKET ERROR: ", err


  App.config = JSON.parse Config
  App.mobile = isMobile()
  App.Modules = {}

  settings = []
  settings.push App.config

  App.Settings = new Settings

  App.addRegions
    navigationRegion:"#navigation"
    contentRegion:"#content"
    infoRegion:"#info"
    overlayRegion: ".modal-body"
    listTopRegion: "#list-top"
    listRegion:"#list"

  # close detailview if now listview is shown
  App.listRegion.on "show", ->
    if App.contentRegion.currentView? then App.contentRegion.currentView.close()

  App.contentRegion.on "close", ->
    clearInterval()

  # init tinymce
  App.contentRegion.on "show", ->
    App.contentRegion.currentView.$el.find(".wysiwyg").tinymce
      theme: "modern"
      menubar : false
      plugins: [
          "advlist autolink lists link charmap print preview hr anchor pagebreak",
          "searchreplace wordcount code fullscreen",
          "insertdatetime nonbreaking table contextmenu directionality",
          "paste"
      ]
      toolbar1: "insertfile undo redo | table | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link code"

    App.contentRegion.currentView.$el.find(".colorpicker").minicolors
      control: $(this).attr('data-control') || 'hue'
      inline: $(this).attr('data-inline') == 'true'
      position: $(this).attr('data-position') || 'top left'
      change: (hex, opacity)-> true
      theme: 'bootstrap'


  App.navItems = new NavItems


  App.Settings.fetch
    success:->
      for key of settings
        setting = App.Settings.where name: settings[key].name
        if setting.length is 0
          setting = new Setting
          setting.set "settings", settings[key].settings
          setting.set "name", settings[key].name
          App.Settings.create setting

  App.Router = new AppRouter

  # App.addInitializer = ()->
  App.navItems.add new NavItem App.config.navigation
  App.navigationRegion.show new NavigationView collection: App.navItems

  App.Utilities.Vent.on 'app:addModule', (config)->
    App.Modules[config.config.name] = config.config
    if config.navigation then App.navItems.add new NavItem config.navigation
    if config.settings then settings.push
      settings:config.settings
      name:config.config.name

    App.Utilities.Vent.trigger config.config.namespace+":ready"

  App.Utilities.Vent.on 'app:updateRegion', (region, view, cb)->
    App[region].show view
    if cb? then cb()

  App.Utilities.Vent.on 'app:closeRegion', (region)->
    App[region].close()

  App.start
    onStart:->
      articleModule = require "cs!./modules/article/ArticleModule"
      magazineModule = require "cs!./modules/magazine/MagazineModule"
      bakerModule = require "cs!./modules/baker/BakerModule"
      settingsModule = require "cs!./modules/settings/SettingsModule"
      fileModule = require "cs!./modules/files/FileModule"
      staticModule = require "cs!./modules/static/StaticModule"
      userModule = require "cs!./modules/user/UserModule"

      # coming soon in 2.0
      messageModule = require "cs!./modules/messages/MessageModule"
      # reportModule = require "cs!./modules/reports/ReportModule"



  App.Utilities.Vent.on 'overlay:action', (cb)->
    $("body").unbind "overlay:ok"
    $("body").on "overlay:ok", cb

  window.App = App
  Backbone.history.start()
  App.Utilities.Vent.trigger 'app:ready'
  App.navItems.add new NavItem App.config.navigation




