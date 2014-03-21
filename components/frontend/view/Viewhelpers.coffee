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
      str = '<div class="row">'
      that = @
      i = 0
      _.each images, (image) ->
        str += '<div class="col-md-3">' + that.renderImage(image) + '</div>'
        if i++ % 4 then str += '</div><div class="row">'
      str += '</div>'

    fileKeyExists: (key) ->
      console.log(!!@getFile(key))
      !!@getFile(key)