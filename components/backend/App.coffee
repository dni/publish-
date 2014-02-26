define (require)->
  
  $ = require 'jquery'
  _ = require 'lodash'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  WelcomeView = require 'cs!./views/WelcomeView'
  NavItems = require 'cs!./models/NavItems'
  NavItem = require 'cs!./models/NavItem'
  NavigationView = require 'cs!./views/NavigationView'
  AppRouter = require 'cs!./router/AppRouter'
  Less = require 'less!./style/main.less'
  Config = require 'text!./configuration/mainConfiguration.json'
  Command = require "cs!./Command"
  
  isMobile = ()->
    userAgent = navigator.userAgent or navigator.vendor or window.opera
    return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))
  
  App = new Backbone.Marionette.Application
  
  App.config = JSON.parse Config
  App.mobile = isMobile()
  App.Modules = {}
  
  App.addRegions
    navigationRegion:"#navigation"
    contentRegion:"#content"
    infoRegion:"#info"
    overlayRegion: "#overlay"
    listTopRegion: "#list-top"
    listRegion:"#list"
    
  App.navItems = new NavItems 
  App.router = new AppRouter

  # App.addInitializer = ()->
    
  Backbone.history.start() 
  App.navigationRegion.show new NavigationView collection: App.navItems
  App.contentRegion.show new WelcomeView


  Command.setHandler 'app:addModule', (module)->
    App.Modules[module.name] = module
    if module.config.navigation then App.navItems.add new NavItem module.config.navigation
    
  Command.setHandler 'app:updateRegion', (region, view)->
    App[region].show view


  App.start
    onStart:->    
      for moduleKey, moduleName of App.config.modules
        # NOT Working :(
        # require "cs!./modules/#{moduleKey}/#{moduleName}"
        # this is working for saylermorph.com ....
        # require([jsUrl]);
      
        require "cs!./modules/article/ArticleModule"
        

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
  
  Command.execute 'app:ready'