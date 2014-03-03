define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/MagazineListView'
  'cs!../view/MagazineDetailView'
  'cs!../model/Magazine'
  'cs!../view/ListView'
], ( Vent, $, _, Backbone, Marionette, MagazineListView, MagazineDetailView, Magazine, ListView) ->

  class MagazineController extends Backbone.Marionette.Controller

    detailsMagazine: (id) ->
      magazine = App.Magazines.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new MagazineDetailView model: magazine[0]
      #view = new MagazineDetailView model: magazine[0]
      #App.contentRegion.show view

    addMagazine: ->
      view = new MagazineDetailView model: new Magazine()
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      #App.contentRegion.show view
      #view.toggleEdit()

    magazines: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new ListView
      console.log new MagazineListView collection: App.Magazines
      Vent.trigger 'app:updateRegion', 'listRegion', new MagazineListView collection: App.Magazines
      #App.sidebarRegion.show view

# define [
  # 'cs!../../../Command'
  # 'jquery'
  # 'lodash'
  # 'backbone'
  # 'marionette'
  # 'cs!../view/MagazineDetailView'
  # 'cs!../view/MagazineListView'
  # 'cs!../model/Magazine'
# ],
# ( Command, $, _, Backbone, Marionette, MagazineDetailView, MagazineListView, Magazine ) ->
#
  # class MagazineController extends Backbone.Marionette.Controller
#
    # generator: ->
      # $.get "generator", (data) -> console.log data
#