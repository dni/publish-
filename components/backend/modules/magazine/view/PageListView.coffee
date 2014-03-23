define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!../templates/page.html',
  'tpl!../templates/page-item.html',
  'cs!../model/Page',
  'jquery.ui'
], ($, _, Backbone, Marionette, Template, ItemTemplate, Page, jqueryui) ->

  class PageListItemView extends Backbone.Marionette.ItemView
    template: ItemTemplate
    initialize:->
      @model.on "change", @render, @

    events:
      "click .remove": "deletePage"
      "change select": "updatePage"

    updatePage: ->
      @model.set
        "number": @$el.find(".number").text()
        "layout": @$el.find(".layout").val()
        "article": @$el.find(".article").val()
      @model.save

    deletePage: ->
      @model.destroy
        success: ->

  class PageListView extends Backbone.Marionette.CompositeView

    template: Template
    itemView: PageListItemView
    itemViewContainer: ".page-list"

    events:
      "click #addPage": 'addPage'

    addPage: ->
      page = new Page number: @collection.length+1
      @collection.create page,
        success:->

    initialize:->
      @$el.sortable(
          revert: true
          axis: "y"
          cursor: "move"
          stop: _.bind @_sortStop, @
       ).disableSelection()

    _sortStop: (event, ui)->
      $(event.target).find('.number').each (i)->
        elNumber = $(@).text()
        model = @collection.where({number: elNumber})[0]
        if model?
          model.attributes.number = (i+1).toString()
        else
          c.l "model nr.#{elNumber} is broken"

        $(@).text(i+1)




