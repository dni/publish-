define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../Command'
  'tpl!../templates/navigation.html'
  "cs!../models/NavItems"
],
($, _, Backbone, Marionette, Command, Template) ->
  
  class NavigationItemView extends Backbone.Marionette.ItemView

  class NavigationView extends Backbone.Marionette.CollectionView
    itemView: new NavigationItemView
    template: Template
       