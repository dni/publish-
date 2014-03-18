define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/StaticBlock'
    'cs!./model/StaticBlocks'
    'cs!./controller/StaticBlockController'
    'text!./configuration.json'
    'text!./templates/blocks/header.html'
    'text!./templates/blocks/logo.html'
], ( Marionette, Vent, StaticBlock, StaticBlocks, Controller, Config , defaultHeaderTpl, defaultLogoTpl) ->

  Vent.on "app:ready", ()->
    Vent.trigger "app:addModule", JSON.parse Config
    App.StaticBlocks = new StaticBlocks
    App.StaticBlocks.fetch
      success:->
        head = App.StaticBlocks.where key: "header"
        c.l "head", head
        if !head[0]?
          sb = new StaticBlock()
          sb.set "key", "header"
          sb.set "data", defaultHeaderTpl
          sb.set "deleteable", false
          App.StaticBlocks.create sb,
            wait: true
            success: ->

        logo = App.StaticBlocks.where key: "logo"
        if !logo[0]?
          sb = new StaticBlock()
          sb.set "key", "logo"
          sb.set "data", defaultLogoTpl
          sb.set "deleteable", false
          App.StaticBlocks.create sb,
            wait: true
            success: ->

    App.Router.processAppRoutes new Controller,
      "staticBlocks": "list"
      "staticBlock/:id": "details"
      "newStaticBlock": "add"
    Vent.trigger "staticBlocks:ready"
