define [
  "backbone"
  "cs!./Page"
], (Backbone, Page) ->

  class Pages extends Backbone.Collection
    url: "/pages/"
    model: Page
    comparator: (item) -> item.get "number"
