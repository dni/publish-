define [
  'cs!App'
  'jquery'
  'jquery.tinymce'
  'minicolors'
  'bootstrap'
], (App, $, tinymce, minicolors, bootstrap) ->

  App.addRegions
    navigationRegion:"#navigation"
    contentRegion:"#content"
    infoRegion:"#info"
    overlayRegion: ".modal-body"
    listTopRegion: "#list-top"
    listRegion:"#list"

  # close detailview if now listview is shown
  App.listRegion.on "show", ->
    if App.contentRegion.currentView? then App.contentRegion.currentView.close()

  App.contentRegion.on "close", ->
    clearInterval()

  App.contentRegion.on "show", ->

    # colorpicker
    App.contentRegion.currentView.$el.find(".colorpicker").minicolors
      control: $(this).attr('data-control') || 'hue'
      inline: $(this).attr('data-inline') == 'true'
      position: $(this).attr('data-position') || 'top left'
      change: (hex, opacity)-> true
      theme: 'bootstrap'

    # tinymce
    App.contentRegion.currentView.$el.find(".wysiwyg").tinymce
      theme: "modern"
      menubar : false
      plugins: [
          "advlist autolink lists link charmap print preview hr anchor pagebreak",
          "searchreplace wordcount code fullscreen",
          "insertdatetime nonbreaking table contextmenu directionality",
          "paste"
      ]
      toolbar1: "insertfile undo redo | table | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link code"