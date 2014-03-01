define ['jquery','lodash','backbone', 'text!templates/public.html'], 
($, _, Backbone, Template) ->
  class PublicView extends Backbone.View
    template: _.template Template
    render: ->
      @$el.html @template()
      @el
