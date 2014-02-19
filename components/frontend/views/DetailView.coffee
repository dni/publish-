define ['jquery', 'lodash', 'backbone', 'text!templates/detail.html'], ( $, _, Backbone, Template) -> 
	
  class DetailView extends Backbone.View
    # Not required since 'div' is the default if no el or tagName specified
    initialize: ->
      @template = _.template Template
      @model.bind "change", this.render, this 

    render: (eventName) ->
      @$el.html @template
        model:this.model.toJSON()
      return @el
        
    events: 
      "click .back": "backLink"
        
    backLink: ->
      app.navigate "", 
            trigger: true