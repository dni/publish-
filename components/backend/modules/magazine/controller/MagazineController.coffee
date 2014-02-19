define [
    'jquery'
    'lodash'
    'backbone'
    'marionette'
    'cs!./views/MagazineDetailView'
    'cs!./views/MagazineListView'
    'cs!./models/Magazine'
],
( $, _, Backbone, Marionette, MagazineDetailView, MagazineListView, Magazine ) ->

  class MagazineController extends Backbone.Marionette.Controller

    generator: ->
      $.get "generator", (data) -> console.log data
      
    detailsMagazine: (id) ->
      magazine = App.magazines.where _id: id
      view = new MagazineDetailView model: magazine[0]
      App.contentRegion.show view

    addMagazine: ->
      view = new MagazineDetailView model: new Magazine()
      App.contentRegion.show view
      view.toggleEdit()

    magazines: ->
      view = new ArticleListView model: App.magazines
      App.sidebarRegion.show view