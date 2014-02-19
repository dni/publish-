define [
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'tpl!../templates/welcome.html'
], 
($, _, Backbone, Marionette, Template) ->   
  class WelcomeView extends Backbone.Marionette.ItemView    
    template: Template
