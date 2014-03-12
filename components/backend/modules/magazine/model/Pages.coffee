define [
  "lodash"
  "backbone"
  "cs!./Page"
],
(_, Backbone, Page) ->
  class Pages extends Backbone.Collection
    model: Pages#
    comparator: 'number'
