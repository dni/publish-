define [
  'backbone'
], (Backbone) ->
  class NavigationItem extends Backbone.Model
    defaults:
      "label": "Neuer Navigationspunkt"
      "route": ""
      "classNames": ""
      "button": 0