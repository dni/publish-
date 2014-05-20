define [
  'marionette'
  'tpl!../templates/listItem.html'
], (Marionette, Template) ->

  class UserListItemView extends Marionette.ItemView
    template: Template

  class UserListView extends Marionette.CollectionView
    itemView: UserListItemView
    initialize: ->
      @collection.on "change", @render
