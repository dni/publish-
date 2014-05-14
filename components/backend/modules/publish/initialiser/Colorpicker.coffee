define [
  'cs!utilities'
  'cs!App'
  'jquery'
], ( Utils, App, $ ) ->
  App.addInitializer ->
    App.contentRegion.on "show", ->
      App.contentRegion.currentView.$el.find(".colorpicker").minicolors
        control: $(this).attr('data-control') || 'hue'
        inline: $(this).attr('data-inline') == 'true'
        position: $(this).attr('data-position') || 'top left'
        change: (hex, opacity)-> true
        theme: 'bootstrap'