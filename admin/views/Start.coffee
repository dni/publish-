define ['jquery','lodash','backbone', 'text!templates/start.html'], ($, _, Backbone, startTemplate) ->   
  class Start extends Backbone.View    
    template: _.template startTemplate
    initialize: ->        
    render: (eventName)->
      @$el.html @template()
      return @el;