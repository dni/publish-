define [
  'cs!App'
  'cs!lib/controller/Controller'
  'cs!lib/view/LayoutView'
], ( App, Controller, LayoutView ) ->
  class LayoutController extends Controller

    constructor: (args)->
      unless args.LayoutView? then @LayoutView = LayoutView
      super args

    getNewFileCollection:->
      cloned = App.Files.clone()
      cloned.reset()
      cloned

    getContentView:(model)->
      c.l "getlayoutview"
      @newLayoutView model

    newLayoutView:(model)->
      detailView = @newDetailView model
      new @LayoutView
        detailView: detailView
        files: files.reset App.Files.where relation: @Config.modelName+":"+id

    add: ->
      detailView = @newDetailView()
      App.contentRegion.show new @LayoutView
        detailView: detailView
        files: @getNewFileCollection()
