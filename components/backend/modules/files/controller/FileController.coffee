define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ListView'
  'cs!../view/BrowseView'
  'cs!../view/DetailView'
  'cs!../view/TopView'
  'cs!../view/ShowFileView'
  'cs!../view/CropFileView'
  'cs!../model/File'
  'cs!../model/Files'

], ( Vent, $, _, Backbone, Marionette, ListView, BrowseView, DetailView, TopView, ShowFileView, CropFileView,File, Files) ->

  class FileController extends Backbone.Marionette.Controller

    filebrowser: (namespace, id)->
      files = App.Files.where parent:undefined
      files.forEach (model)->
        model.set 'selected', false

      view = new BrowseView collection: new Files files

      Vent.trigger 'overlay:action', ->

        files = view.collection.where selected:true
        if !files.length then return $('.modal').modal('hide')

        # filecollection of fileRegion
        fileView = App.contentRegion.currentView.fileRegion.currentView

        eachFile = (file)->
          newfile = new File()
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

      Vent.trigger 'app:updateRegion', 'overlayRegion', view

    showfile: (id) ->
      fileView = App.contentRegion.currentView.fileRegion.currentView
      view = new ShowFileView model: fileView.collection.findWhere _id: id

      Vent.trigger 'app:updateRegion', 'overlayRegion', view
      Vent.trigger 'overlay:action', ->
        $('.modal').modal('hide')

    cropfile: (id) ->
      c.l "cropfile .. controller"
      fileView = App.contentRegion.currentView.fileRegion.currentView
      view = new CropFileView model: fileView.collection.findWhere _id: id

      Vent.trigger 'app:updateRegion', 'overlayRegion', view
      Vent.trigger 'overlay:action', ->
        $('.modal').modal('hide')

    show: (id) ->
      file = App.Files.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: file[0]

    list : ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: new Files App.Files.where parent:undefined
      #App.sidebarRegion.show view
