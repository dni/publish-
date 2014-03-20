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
  'cs!../model/File'
  'cs!../model/Files'

], ( Vent, $, _, Backbone, Marionette, ListView, BrowseView, DetailView, TopView, ShowFileView, File, Files) ->

  class FileController extends Backbone.Marionette.Controller

    filebrowser: (eventname, id)->

      files = App.Files.where parent:undefined
      view = new BrowseView collection: new Files files

      Vent.trigger 'overlay:action', ->
        files = App.Files.where selected:true
        filesIds = []
        _.each files, (file)->

          cloned = new File()
          cloned.set
            parent: file.get "_id"
            relation: eventname+":"+id
            type: file.get "type"
            name: file.get "name"
            info: file.get "info"
            alt: file.get "alt"
            desc: file.get "desc"

          App.Files.create cloned,
            wait:true
            success: (res) ->
              App.contentRegion.currentView.render()

        $('.modal').modal('hide')
        Vent.trigger 'app:closeRegion', 'overlayRegion'


      Vent.trigger 'app:updateRegion', 'overlayRegion', view
      # App.Router.navigate collection+"/"+id


    showfile: (id) ->
      file = App.Files.where _id: id
      view = new ShowFileView model: file[0]
      Vent.trigger 'app:updateRegion', 'overlayRegion', view
      Vent.trigger 'overlay:action', ->
        $('.modal').modal('hide')


    show: (id) ->
      file = App.Files.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: file[0]

    list : ->
      App.Files.on 'sync', ->
        Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: new Files App.Files.where parent:undefined

      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: new Files App.Files.where parent:undefined
      #App.sidebarRegion.show view
