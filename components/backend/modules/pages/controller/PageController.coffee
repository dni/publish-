define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'marionette'
  'cs!modules/pages/view/PageDetailView'
  'cs!modules/pages/view/PageListView'
  'cs!utilities/views/TopView'
  'cs!modules/pages/model/Page'
  'cs!modules/pages/model/Pages'
  'i18n!modules/pages/nls/language.js'
  'cs!utilities/views/EmptyView'
], ( App, Router, Utils, Marionette, DetailView, ListView, TopView, Page, Pages, i18n, EmptyView) ->

  class PageController extends Marionette.Controller

    detailsPage: (id) ->
      page = App.Pages.findWhere _id: id
      if page
        Utils.Vent.trigger 'app:updateRegion', "contentRegion", new DetailView
          model: page
      else
        Utils.Vent.trigger 'app:updateRegion', "contentRegion", new EmptyView message: i18n.emptyMessage

    addPage: ->
      Utils.Vent.trigger 'app:updateRegion', 'contentRegion', new DetailView
        model: new Page

    pages: ->
      Utils.Vent.trigger 'app:updateRegion', 'listTopRegion', new TopView navigation: i18n.navigation, newModel: 'newPage'
      Utils.Vent.trigger 'app:updateRegion', 'listRegion', new ListView collection: App.Pages
