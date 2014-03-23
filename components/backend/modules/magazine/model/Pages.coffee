define [
  "lodash"
  "backbone"
  "cs!./Page"
],
(_, Backbone, Page) ->
  class Pages extends Backbone.Collection
    url: "/pages/"
    model: Page
    comparator: (item) -> item.get "number"
