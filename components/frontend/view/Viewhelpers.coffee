define [], () ->

  Viewhelpers =

    getFile: (key) ->
      _.find @files, (file)->
        file.key == key

    getFilesByType: (type) ->
      _.filter @files, (file)->
       file.type == 'image/png' or 'image/jpeg'

    renderImage: (key) ->
      if typeof key is 'string'
        image = @getFile key
      else
        image = key
      '<img src="'+ image.link + '" alt="'+image.alt+'"/>'

    renderImages: ->
      images = @getFilesByType 'image'
      that = @
      i = 0
      str = '<div class="row">'
      _.each images, (image) ->
        str += '<div class="col-md-3 col-xs-6"><a href="'+image.link+'" rel="gallery" class="thumbnail">' + that.renderImage(image) + '</a></div>'
      str += '</div>'

    fileKeyExists: (key) ->
      !!@getFile(key)