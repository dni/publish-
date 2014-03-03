define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/MagazineListView'
  'cs!../view/MagazineDetailView'
  'cs!../model/Magazine'
],
( Vent, $, _, Backbone, Marionette, MagazineListView, MagazineDetailView, Magazine) ->

  class MagazineController extends Backbone.Marionette.Controller

    details: (id) ->
      magazine = App.Magazines.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new MagazineDetailView model: magazine[0]

    add: ->
      view = new MagazineDetailView model: new Magazine
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()

    list: ->
      #Vent.trigger 'app:updateRegion', 'listTopRegion', new ListView
      Vent.trigger 'app:updateRegion', 'listRegion', new MagazineListView collection: App.Magazines

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
    # detailsMagazine: (id) ->
      # magazine = App.magazines.where _id: id
      # view = new MagazineDetailView model: magazine[0]
      # App.contentRegion.show view
#
    # addMagazine: ->
      # view = new MagazineDetailView model: new Magazine()
      # App.contentRegion.show view
      # view.toggleEdit()
#
    # magazines: ->
      # view = new ArticleListView model: App.magazines
      # App.sidebarRegion.show view