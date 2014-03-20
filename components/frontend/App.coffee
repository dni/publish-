define [
    'jquery',
    'lodash',
    'backbone',
    'marionette',
    'cs!/router/FrontendRouter'
    'cs!view/ListView',
    'cs!./view/DetailView',
    'cs!./model/Articles',
    "less!style/frontend"
],
( $, _, Backbone, Marionette, Router, ListView, DetailView, Articles, Magazines ) ->

  App = new Backbone.Marionette.Application();

  isMobile = ()->
    userAgent = navigator.userAgent or navigator.vendor or window.opera
    return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))

  App.addRegions
    navigationRegion:"#navigation"
    contentRegion:"#content"
    infoRegion:"#info"
    overlayRegion: "#overlay"
    sidebarRegion:"#sidebar"

  App.addInitializer ()->
    Backbone.history.start()

    # Fileparser.parse()

    # $.get "staticBlocks/header", (data)->
      # $("header").html(data)

    $.get "staticBlocks/logo", (data)->
      $("logo").html(data)

    App.articles = new Articles()

    App.articles.fetch
      success: ->

    App.Router = new Router()

  App.start()
