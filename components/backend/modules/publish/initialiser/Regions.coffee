define [
  'cs!utilities'
  'cs!App'
], ( Utils, App ) ->

  App.addInitializer ->

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
