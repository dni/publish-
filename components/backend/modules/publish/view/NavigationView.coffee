define [
  'jquery'
  'marionette'
  'tpl!../templates/navItem.html'
],
($, Marionette, Template) ->

  class NavigationItemView extends Marionette.ItemView
    template: Template
    tagName: 'li'
    initialize:->
      if @model.get("button") then @$el.addClass "pull-right"

  class NavigationView extends Marionette.CollectionView
    el: "#navigation"
    itemView: NavigationItemView

    events:
      "click a": "clicked"

    clicked: (e)->
      @children.each (view)->
        view.$el.removeClass "active"

      target = $(e.target) # clicked li
      if target[0].nodeName.toLowerCase() is 'a'
        target = target.parent() # clicked link
      else if target[0].nodeName.toLowerCase() is 'span' # clicked icon
        target = target.parent().parent()

      target.addClass "active"
