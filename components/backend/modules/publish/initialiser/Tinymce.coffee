define [
  'cs!utilities'
  'cs!App'
], ( Utils, App ) ->
  App.addInitializer ->
    App.contentRegion.on "show", ->
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