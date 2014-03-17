define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/previewItem.html'
], ($, _, Backbone, Template) ->

  class ItemView extends Backbone.Marionette.ItemView
    template: Template

  class PreviewView extends Backbone.Marionette.CollectionView
    itemView: ItemView
