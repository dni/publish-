define [
  'cs!App'
  'cs!Router'
  'marionette'
  'tpl!../templates/preview.html'
  'tpl!../templates/preview-item.html'
  'jquery.ui'
], (App, Router, Marionette, Template, ItemTemplate) ->


  class ItemView extends Marionette.ItemView
    template: ItemTemplate
    className: "preview-item"

    initialize:->
      @listenTo @model, 'destroy', @close

    events:
      "click": "showFile"

    showFile: ->
      Router.navigate("showfile/"+@model.get('_id'), {trigger:true})


  class PreviewView extends Marionette.CompositeView

    template: Template
    itemView: ItemView
    itemViewContainer: ".file-list"

    initialize:(args)->
      @modelId = args['modelId']
      @namespace = args['namespace']

      @$el.find(".file-list").sortable(
        revert: true
        cursor: "move"
        # stop: _.bind @_sortStop, @
      ).disableSelection()

    events:
      "click #files": "add"

    add:->
      Router.navigate("filebrowser/#{@namespace}/#{@modelId}", {trigger:true})