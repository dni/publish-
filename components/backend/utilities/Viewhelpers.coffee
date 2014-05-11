define [], () ->
  Viewhelpers =
    formatDate: (date)->
      if date not typeof Date then new Date(date)
      date.format()
