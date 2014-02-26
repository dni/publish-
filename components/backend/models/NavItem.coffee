define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class NavItem extends Backbone.Model
    defaults: 
      "label": "Neuer Navigationspunkt"
      "route": ""
      "classNames": ""
      "button": 0