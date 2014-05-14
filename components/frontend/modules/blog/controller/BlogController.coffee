define [
    'cs!utilities/App'
    'marionette'
    'cs!./../model/Articles'
    'cs!./../view/ListView'
    'cs!./../view/DetailView'
], (App, Marionette, Articles, ListView, DetailView) ->
  class BlogController extends Marionette.Controller

    list: ->
      App.contentRegion.show new ListView collection: Articles

    details: (id) ->
      article = Articles.findWhere _id: id
      App.contentRegion.show new DetailView model: article
