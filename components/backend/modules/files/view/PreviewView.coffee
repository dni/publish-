define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/previewItem.html'
  'd3'
], ($, _, Backbone, Template, d3) ->

  window.d3 = d3

  class ItemView extends Backbone.Marionette.ItemView
    template: Template
    className: "preview-item"

  class PreviewView extends Backbone.Marionette.CollectionView
    itemView: ItemView
