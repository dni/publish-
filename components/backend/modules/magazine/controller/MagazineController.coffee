define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/MagazineLayout'
  'cs!../view/MagazineListView'
  'cs!../view/TopView'
  'cs!../model/Magazine'
  'cs!../model/Magazines'
  'cs!../model/Pages'
  'cs!../../files/model/Files'
], ( Vent, $, _, Backbone, Marionette, MagazineLayout, MagazineListView, TopView, Magazine, Magazines, Pages, Files) ->

  class MagazineController extends Backbone.Marionette.Controller

    detailsMagazine: (id) ->
      pages = new Pages
      pages.fetch
        data:
          magazine:id
      Vent.trigger 'app:updateRegion', "contentRegion", new MagazineLayout
        model: App.Magazines.findWhere _id: id
        files: new Files App.Files.where relation: "magazine:"+id
        pages: pages


    addMagazine: ->
      Vent.trigger 'app:updateRegion', 'contentRegion', new MagazineLayout
        model: new Magazine
        files: new Files()
        pages: new Pages()

    magazines: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new MagazineListView collection: App.Magazines
