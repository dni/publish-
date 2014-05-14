define [
  'cs!utils'
  'marionette'
  'cs!modules/magazine/view/MagazineLayout'
  'cs!modules/magazine/view/MagazineListView'
  'cs!modules/magazine/view/TopView'
  'cs!modules/magazine/model/Magazine'
  'cs!modules/magazine/model/Magazines'
  'cs!modules/magazine/model/Pages'
  'cs!modules/files/model/Files'
], ( Utils, Marionette, MagazineLayout, MagazineListView, TopView, Magazine, Magazines, Pages, Files) ->

  class MagazineController extends Marionette.Controller
    detailsMagazine: (id) ->
      pages = new Pages
      pages.fetch
        data:
          magazine:id
      Utils.Vent.trigger 'app:updateRegion', "contentRegion", new MagazineLayout
        model: App.Magazines.findWhere _id: id
        files: new Files App.Files.where relation: "magazine:"+id
        pages: pages


    addMagazine: ->
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', new MagazineLayout
        model: new Magazine
        files: new Files()
        pages: new Pages()

    magazines: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView
      Vent.trigger 'app:updateRegion', 'listRegion', new MagazineListView collection: App.Magazines
