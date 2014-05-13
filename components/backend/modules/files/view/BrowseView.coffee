define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/browseItem.html'
], ($, _, Backbone, Template) ->

  class ItemView extends Backbone.Marionette.ItemView
    template: Template
    events:
      "click input": 'toggleSelect'
      "click #upload": 'uploadFile'

    toggleSelect: -> @model.set "selected", !@model.get "selected"
    uploadFile: -> App.router.navigate "upl"

  class BrowseView extends Backbone.Marionette.CollectionView
    itemView: ItemView

    initialize: ->
      App.Files.on "sync", @sync, @

      @$el.prepend '''
        <form class="form-inline form-plugin" action="/uploadFile" method="POST" id="uploadFile" enctype="multipart/form-data">
          <div class="btn btn-default fileinput-button">
              <span class="glyphicon glyphicon-cloud-upload"></span>
              <input id="upload" type="file" name="files[]" multiple="multiple">
          </div>
        </form>
      '''

    events:
      "change #upload": "uploadFile"

    uploadFile: ->
      @$el.find("#uploadFile").ajaxForm (response) ->
      @$el.find("#uploadFile").submit()
#
    sync: ->
      files = App.Files.where parent:undefined
      files.forEach (model)->
        model.set 'selected', false
      @collection.reset files
      @render()
