define [
  'cs!App'
  'cs!lib/controller/Controller'
], ( App, Controller ) ->
  class LayoutController extends Controller

    constructor: (args)->
      unless args.LayoutView? then @LayoutView = LayoutView
      super args

    getNewFileCollection:->
      cloned = App.Files.clone()
      cloned.reset()
      cloned

    details: (id) ->
      model = App[@Config.collectionName].findWhere _id: id
      if model
        files = @getNewFileCollection()
        view = new @LayoutView
          detailView: @DetailView
          model: model
          files: files.reset App.Files.where relation: "article:"+id
        view.i18n = @i18n
      else
        view = new EmptyView message: @i18n.emptyMessage

      App.contentRegion.show view


    add: ->
      App.contentRegion.show new @LayoutView
        detailView: new @DetailView
        model: new @Model
        files: @getNewFileCollection()
