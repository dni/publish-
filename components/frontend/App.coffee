define [
    'jquery'
    'lodash'
    'backbone'
    'marionette'
    'cs!./router/FrontendRouter'
    'cs!./view/BlockView'
    'cs!./view/ListView'
    'cs!./view/DetailView'
    'cs!./model/Articles'
    'cs!./model/StaticBlocks'
    "less!./style/frontend"
],
( $, _, Backbone, Marionette, Router, BlockView, ListView, DetailView, Articles, Blocks ) ->

  window.App = App = new Backbone.Marionette.Application();

  isMobile = ()->
    userAgent = navigator.userAgent or navigator.vendor or window.opera
    return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))

  App.addRegions
    contentRegion:"#list"

  App.addInitializer ()->

    App.Blocks = new Blocks()
    blocks = $.map $('[block]'), (o) -> $(o).attr 'block'

    App.Blocks.fetch
      data:
        blocks:blocks
      success: ->

    App.Articles = new Articles()
    App.Articles.fetch
      success: ->

    App.Router = new Router()

    App.contentRegion.show new ListView collection: App.Articles
    App.BlockView = new BlockView collection: App.Blocks

  App.on "initialize:after", (options)->
    Backbone.history.start()


  App.start()

