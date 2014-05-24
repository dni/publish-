gm = require "gm"
fs = require "fs-extra"
sizeList = require "./AppAssets"
File = require "./../../files/model/FileSchema"

module.exports = (setting, cb)->

  formats = ["shelf", "launch", "icon"]

  background = './templates/bg.jpg'
  File.find(relation: 'setting:'+setting._id).exec (err, files)->
    console.log files
    if err then return
    for file of files
      background = file.name if file.key is 'background'
      logo = file.name if file.key is 'logo'
      icon = file.name if file.key is 'icon'
    createIcons formats.pop(), icon, logo, background

  createIcons = (format, icon, logo, background)->
    key = if format is "icon" then "icon" else "logo"
    size = if key is "logo" then width:1024,height:768 else width:286,height:286
    image = gm()
    filetype = "png"
    iconInfos = sizeList[format]
    console.log iconInfos, typeof iconInfos
    createIcon = (imgData)->
      targetDir = './cache/publish-baker/Baker/BakerAssets.xcassets/'
      if format is "icon"
        image = gm('./public/files/'+icon)
        image.resize imgData.w
        if imgData.h>imgData.w
          image.extent imgData.w, imgData.h
          image.in "-background", "transparent"
          targetDir += "newsstand-app-icon.imageset"
        else
          targetDir += "AppIcon.appiconset"
        writeImage image, imgData, targetDir
      else
        newImg = "tmpImg."+logo.split(".").pop()
        newBg = "tmpBg."+background.split(".").pop()
        gm('./public/files/'+logo).resize(imgData.w / 3).write './public/files/'+newImg, ->
          gm(background).crop(imgData.w, imgData.h, (1024-imgData.w / 2), (1024-imgData.h / 2)).write './public/files/'+newBg, ->
            if format is "shelf"
              if imgData.n.indexOf("portrait")>1 then targetDir += "shelf-bg-portrait.imageset" else targetDir += "shelf-bg-landscape.imageset"
            else if format is "launch"
              targetDir += "LaunchImage.launchimage"
            image
              .in('-page', '+0+0').in('./public/files/'+newBg)
              .in('-page', '+'+((imgData.w-imgData.w/3)/2)+'+'+((imgData.h-imgData.h/4)/3)+'')
              .in('./public/files/'+newImg).flatten()

            writeImage image, imgData, targetDir

    # write the image
    writeImage = (image, imgData, targetDir) ->
      targetImageLink = targetDir+"/"+imgData.n+"."+filetype
      image.write targetImageLink, (err)->
        if err then return console.error("icon.write err=", err)
        # check if icon variation is left
        if iconInfos.length>0 then createIcon iconInfos.pop()
        else
          # check if format variation is left
          if formats.length>0 then createIcons formats.pop()
          # else all done
          else cb()

    # start it up
    createIcon iconInfos.pop()