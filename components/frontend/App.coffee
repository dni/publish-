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

  window.App = App = new Backbone.Marionette.Application();

  isMobile = ()->
    userAgent = navigator.userAgent or navigator.vendor or window.opera
    return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))

  App.addRegions
    contentRegion:"#list"

  App.addInitializer ()->

    # Fileparser.parse()

    $.get "staticBlocks/logo", (data)->
      $("logo").html(data)

    App.Articles = new Articles()

    App.Articles.fetch
      success: ->



    App.Router = new Router()

  App.on "initialize:after", (options)->
    Backbone.history.start()
    App.contentRegion.show new ListView collection: App.Articles

  App.start()

