define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/listItem.html'
], ($, _, Backbone, Template) ->

  class UserListItemView extends Backbone.Marionette.ItemView
    template: Template

  class UserListView extends Backbone.Marionette.CollectionView
    itemView: UserListItemView
    initialize: ->
      @collection.on "change", @render
