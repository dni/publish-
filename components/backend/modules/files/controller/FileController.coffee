define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/ListView'
  'cs!../view/DetailView'
  'cs!../view/TopView'
  'cs!../model/File'
  'cs!../model/Files'

], ( Vent, $, _, Backbone, Marionette, ListView, DetailView, TopView, File, Files) ->

  class MagazineController extends Backbone.Marionette.Controller

    detailsFile: (id) ->
      file = App.Magazines.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new DetailView model: files[0]

    addFile: ->
      c.l "addFileAction from Controller"
      #view = new MagazineParentView model: new Magazine()
      #Vent.trigger 'app:updateRegion', 'contentRegion', view

    list : ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.Files
      #App.sidebarRegion.show view
