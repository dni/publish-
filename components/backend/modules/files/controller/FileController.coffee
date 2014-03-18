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
  'cs!../model/File'
  'cs!../model/Files'

], ( Vent, $, _, Backbone, Marionette, ListView, BrowseView, DetailView, TopView, File, Files) ->

  class FileController extends Backbone.Marionette.Controller

    filebrowser: (eventname, id)->


      files = App.Files.where relation:eventname+":"+id
      # SET SELECTED
      _.each files, (file)->
        files.set "selected", true

      view = new BrowseView collection: App.Files

      Vent.trigger 'overlay:action', ->
        files = view.collection.where selected:true
        _.each files, (file)->
          cloned = file.clone()
          cloned.set "parent", file.get "_id"
          cloned.set "relation", eventname+":"+id
          App.Files.add cloned


      Vent.trigger 'app:updateRegion', 'overlayRegion', view
      # App.Router.navigate collection+"/"+id


    show: (id) ->
      file = App.Files.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: file[0]

    list : ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.Files
      #App.sidebarRegion.show view
