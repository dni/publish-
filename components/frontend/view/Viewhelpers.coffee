define [], () ->

  Viewhelpers =

    getFile: (key) ->
      _.find @files, (file)->
        file.key == key

    getFilesByType: (type) ->
      _.filter @files, (file)->
       file.type == 'image/png' or 'image/jpeg'

    renderImage: (key, size) ->
      if size? then size = 'smallPic'
      if typeof key is 'string'
        image = @getFile key
      else
        image = key
      '<img src="static/files/'+ image[size] + '" alt="'+image.alt+'"/>'

    renderImages: ->
      images = @getFilesByType 'image'
      that = @
      i = 0
      str = '<div class="row">'
      _.each images, (image) ->
        str += '<div class="col-md-3 col-xs-6"><a href="static/files/'+image.bigPic+'" rel="gallery" class="thumbnail">' + that.renderImage(image, 'thumbnail') + '</a></div>'
      str += '</div>'

    fileKeyExists: (key) ->
      !!@getFile(key)