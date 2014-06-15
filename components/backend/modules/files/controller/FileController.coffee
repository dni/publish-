define [
  'cs!App'
  'cs!utils'
  'i18n!modules/files/nls/language.js'
  'jquery'
  'marionette'
  'cs!../view/ListView'
  'cs!../view/BrowseView'
  'cs!../view/DetailView'
  'cs!../view/TopView'
  'cs!utilities/views/EmptyView'
  'cs!../view/ShowFileView'
  'cs!../view/EditFileView'
  'cs!../model/File'
  'cs!../model/Files'

], ( App, Utils, i18n, $, Marionette, ListView, BrowseView, DetailView, TopView, EmptyView, ShowFileView, EditFileView, File, Files) ->
  class FileController extends Marionette.Controller

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

      Utils.Vent.trigger 'app:updateRegion', 'overlayRegion', view

    showfile: (id) ->
      view = new ShowFileView model: App.Files.findWhere _id: id

      Utils.Vent.trigger 'app:updateRegion', 'overlayRegion', view
      Utils.Vent.trigger 'overlay:action', ->
        $('.modal').modal('hide')

    editfile: (id) ->
      view = new EditFileView model: App.Files.findWhere _id: id

      App.overlayRegion.show view
      Utils.Vent.trigger 'overlay:action', ->
        $('.modal').modal('hide')


    show: (id) ->
      file = App.Files.findWhere _id: id
      if file
        Utils.Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: file
      else
        Utils.Vent.trigger 'app:updateRegion', "contentRegion", new EmptyView message: i18n.emptyMessage


    list : ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: new Files App.Files.where parent:undefined
      #App.sidebarRegion.show view
