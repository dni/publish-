define (require)->

  $ = require 'jquery'
  _ = require 'lodash'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  WelcomeView = require 'cs!./view/WelcomeView'
  Setting = require 'cs!./modules/settings/model/Setting'
  Settings = require 'cs!./modules/settings/model/Settings'
  NavItems = require 'cs!./model/NavItems'
  NavItem = require 'cs!./model/NavItem'
  NavigationView = require 'cs!./view/NavigationView'
  AppRouter = require 'cs!./router/AppRouter'
  Less = require 'less!./style/main.less'
  Config = require 'text!./configuration/mainConfiguration.json'
  Vent = require "cs!./utilities/Vent"
  Bootstrap = require "bootstrap"

  isMobile = ()->
    userAgent = navigator.userAgent or navigator.vendor or window.opera
    return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))

  # Global c.l for console.log
  window.c = console; c.l = c.log

  App = new Backbone.Marionette.Application

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

  App.navigationRegion.show new NavigationView collection: App.navItems
  App.contentRegion.show new WelcomeView

  Vent.on 'app:addModule', (config)->
    App.Modules[config.config.name] = config.config
    if config.navigation then App.navItems.add new NavItem config.navigation
    if config.settings then settings.push
      settings:config.settings
      name:config.config.name

    Vent.trigger config.config.namespace+":ready"

  Vent.on 'app:updateRegion', (region, view)->
    App[region].show view

  Vent.on 'app:closeRegion', (region)->
    App[region].close()

  App.start
    onStart:->
      articleModule = require "cs!./modules/article/ArticleModule"
      magazineModule = require "cs!./modules/magazine/MagazineModule"
      settingsModule = require "cs!./modules/settings/SettingsModule"
      fileModule = require "cs!./modules/files/FileModule"
      # for moduleKey, moduleName of App.config.modules
        # NOT Working :(
        # str "cs!./modules/#{moduleKey}/#{moduleName}"
        # require str
        #require "cs!./modules/magazine/MagazineModule"


  App.uploadHandler = (selector, model) ->
    xhr = $(selector).FileUpload
      dataType: 'json'
      url: 'http://localhost:8888'

      done: (e, data) ->
        $.each data.result.files, (index, file) ->
          $('#files').append '<img src="static/articles/' + file.name + '" />'

      progressall: (e, data) ->
        progress = parseInt data.loaded / data.total * 100, 10
        $(selector + " output").append "progressALL = "+progress + '%'

  window.App = App
  Backbone.history.start()
  Vent.trigger 'app:ready'