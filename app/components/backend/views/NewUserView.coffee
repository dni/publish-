define ['jquery','lodash','backbone', 'text!templates/newuser.html'], 
($, _, Backbone, Template) ->
  class NewUserView extends Backbone.View
    template: _.template Template
    render: ->
      console.log @template()
      @$el.html @template()
      @el
    events: ->
      "click a": "newUser"
      
    newUser: ->
      app.navigate "newUser", true
