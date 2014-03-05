define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/listItem.html'
  'tpl!../templates/list.html'
  #'tpl!../templates/filter.html'
],
($, _, Backbone, ItemTemplate, ListTemplate) ->

  class MagazineListItemView extends Backbone.Marionette.ItemView
    template: ItemTemplate  
    
    initialize:->
      @model.on "change", @render

  class MagazineListView extends Backbone.Marionette.CollectionView
    itemView: MagazineListItemView

# define [
  # 'jquery'
  # 'lodash'
  # 'backbone'
  # 'text!../templates/listItem.html'
  # #'text!../templates/listMagItem.html'
  # 'text!../templates/filter.html'
# ]
#
# ($, _, Backbone, Template, FilterTemplate) ->
#
  # class MagazineListView extends Backbone.Marionette.CollectionView
    # itemView: new ListItemView
#
  # class MagazineListItemView extends Backbone.Marionette.ItemView
    # template: Template
    # initialize: ->
      # @model.bind "change", @render, @
      # @model.bind "destroy", @close, @
    # render: ->
      # @$el.html @template @model.toJSON()
      # @el
#
  # class FilterView extends Backbone.View
    # tagName: 'fieldset'
    # initialize: ->
      # @template = _.template FilterTemplate
    # render: ->
      # @$el.html @template()
      # @el
    # events:
      # "click #add": "addAction"
    # addAction: ->
      # if $("#showMagazines").parent().hasClass("active") then App.navigate "article/new", true else App.navigate "magazine/new", true
      # return false
#
#
  # class ListView extends Backbone.View
    # tagName: 'ul'
    # initialize: ->
      # @model.bind "reset", @addAll, @
      # @model.bind "add", @addOne, @
    # addAll: ->
      # view = new FilterView
      # @$el.prepend view.render()
      # _.each  @model.models,
        # (model) ->
          # @addOne(model)
        # @
      # @el
    # addOne: (model) ->
      # view = new ListItemView model: model
      # @$el.append view.render()
      # @el