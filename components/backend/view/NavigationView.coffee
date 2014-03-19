define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!../templates/navItem.html'
],
($, _, Backbone, Marionette, Template) ->

  class NavigationItemView extends Backbone.Marionette.ItemView
    template: Template
    tagName: 'li'
    initialize:->
      if @model.get("button") then @$el.addClass "pull-right"

  class NavigationView extends Backbone.Marionette.CollectionView
    el: "#navigation"
    itemView: NavigationItemView

    events:
      "click li": "clicked"

    clicked: (e)->
      @children.each (view)->
        view.$el.removeClass "active"
      $(e.target).parent().addClass "active"
