define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/MagazineListView'
  'cs!../view/MagazineDetailView'
  'cs!../view/MagazineParentView'
  'cs!../model/Magazine'
  'cs!../view/ListView'
  'cs!../model/Pages'
  'cs!../view/PageListView'
], ( Vent, $, _, Backbone, Marionette, MagazineListView, DetailView, MagazineParentView, Magazine, ListView, Pages, PageListView) ->

  class MagazineController extends Backbone.Marionette.Controller

    detailsMagazine: (id) ->
      magazine = App.Magazines.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new MagazineParentView model: magazine[0]

    addMagazine: ->
      view = new MagazineParentView model: new Magazine()
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()

    magazines: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new ListView
      Vent.trigger 'app:updateRegion', 'listRegion', new MagazineListView collection: App.Magazines
