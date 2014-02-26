define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../Command'
  'tpl!../templates/navigation.html'
  'tpl!../templates/navItem.html'
  "cs!../models/NavItems"
  "cs!../models/NavItem"
],
($, _, Backbone, Marionette, Command, Template, ItemTemplate, NavItems, NavItem) ->
  
  class NavigationItemView extends Backbone.Marionette.ItemView
    template: ItemTemplate
    className: 'navitem'


  class NavigationView extends Backbone.Marionette.CollectionView
    el: "#navigation"
    itemView: NavigationItemView
    template: Template   

