define ['jquery', 'lodash', 'backbone', 'text!templates/detail.html'], ( $, _, Backbone, Template) -> 
	
  class DetailView extends Backbone.View
    # Not required since 'div' is the default if no el or tagName specified
    initialize: ->
      @template = _.template Template
      @model.bind "change", @render, @ 

    render: (eventName) ->
      @$el.html @template
        model:@model.toJSON()
      return @el
