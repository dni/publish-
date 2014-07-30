define [
  'cs!App'
  'cs!Publish'
  'cs!utils'
  'i18n!modules/files/nls/language.js'
  'jquery'
  'cs!../view/ListView'
  'cs!../view/BrowseView'
  'cs!../view/TopView'
  'cs!../view/ShowFileView'
  'cs!../view/EditFileView'
], ( App, Publish, Utils, i18n, $, ListView, BrowseView, TopView, ShowFileView, EditFileView) ->
  class FileController extends Publish.Controller.Controller

    constructor:(args)->
      super args
      console.log @
    # routes:
    #   "showfile/:id": "showfile"
    #   "editfile/:id": "editfile"
    #   "filebrowser/:collection/:id": "filebrowser"

    showfile: (id) ->
      App.overlayRegion.show new ShowFileView
        model: App.Files.findWhere _id: id

    editfile: (id) ->
      App.overlayRegion.show new EditFileView
        model: App.Files.findWhere _id: id

    list: ->
      console.log TopView, "lol"
      App.listTopRegion.show new TopView
      App.listRegion.show new ListView
        collection: new @Collection App.Files.where parent:undefined

    filebrowser: (namespace, id)->
      files = App.Files.where parent:undefined
      files.forEach (model)->
        model.set 'selected', false
      view = new BrowseView collection: new Files files
      Utils.Vent.trigger 'overlay:action', ->
        files = view.collection.where selected:true
        if !files.length then return $('.modal').modal('hide')
        # filecollection of fileRegion
        fileView = App.contentRegion.currentView.fileRegion.currentView

        eachFile = (file)->
          newfile = new @Model()
          newfile.attributes =
            parent: file.attributes._id
            relation: namespace+":"+id
            type: file.attributes.type
            name: file.attributes.name
            info: file.attributes.info
            alt: file.attributes.alt
            desc: file.attributes.desc
            key: 'default'
          fileView.collection.create newfile,
            wait:true
            success: (res) ->
              if files.length
                eachFile files.pop()
              else
                App.Files.fetch()
                $('.modal').modal('hide')
        eachFile(files.pop())
      App.overlayRegion.show view
