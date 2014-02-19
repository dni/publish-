define [
    'jquery',
    'lodash',
    'backbone',
    'marionette',
    'cs!router/AppRouter'
    'cs!views/WelcomeView',
    'cs!views/ArticleListView',
    'cs!views/NavigationView',
    'cs!models/Articles',
    'cs!models/Magazines',
    'fileupload',
],
( $, _, Backbone, Marionette, WelcomeView, ArticleListView, NavigationView, Articles, Magazines, FileUpload ) ->

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
    
    App.articles = new Articles()
    App.magazines = new Magazines()
    
    App.articles.fetch
      success: ->
        # onstart show article listview
        App.navigationRegion.show new ArticleListView model: App.articles
      error: ->
        console.log "error fetching articles"

    App.magazines.fetch
      success: ->
      error: ->
         console.log "error fetching magazines"

    new AppRouter()
