define ['jquery','lodash','backbone', 'text!../templates/login.html'],
($, _, Backbone, Template) ->
  class LoginView extends Backbone.View
    template: _.template Template
    render: ->
      @$el.html @template()
      return @el