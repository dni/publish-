define [
  'cs!App'
  'marionette'
  'tpl!../templates/list-item.html'
], (App, Marionette, Files, Template) ->

  class ItemView extends Marionette.ItemView
    template: Template
    initialize: ->
      @model.on "change", @render


  class ListView extends Marionette.CollectionView
    itemView: ItemView
    initialize: ->
      App.Files.on "sync", @sync, @

    sync: ->
      files = App.Files.where parent:undefined
      @collection.reset files
      @render()
