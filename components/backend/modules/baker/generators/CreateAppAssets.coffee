gm = require "gm"
fs = require "fs-extra"
completeSizeList = require "./AppAssets"
File = require "./../../files/model/FileSchema"
extend = require('util')._extend

module.exports = (setting, cb)->
  sizeList = extend {}, completeSizeList
  formats = ["shelf", "launch", "icon"]
  icon=''
  background=''
  logo=''
  File.find(relation: 'setting:'+setting._id).exec (err, files)->
    if err then return
    if files.length is not 0
      for i of files
        if files[i].key is 'background' then background = process.cwd()+'/public/files/'+files[i].name
        if files[i].key is 'logo' then logo = process.cwd()+'/public/files/'+files[i].name
        if files[i].key is 'icon' then icon = process.cwd()+'/public/files/'+files[i].name

    if background? then background = __dirname+'/templates/bg.jpg'
    if logo? then logo = __dirname+'/templates/logo.png'
    if icon? then icon = __dirname+'/templates/icon.png'
    createIcons formats.pop()

  createIcons = (format)->
    key = if format is "icon" then "icon" else "logo"
    size = if key is "logo" then width:1024,height:768 else width:286,height:286
    image = gm()

    iconInfos = sizeList[format]
    createIcon = (imgData)->
      targetDir = process.cwd()+'/cache/publish-baker/Baker/BakerAssets.xcassets/'
      if format is "icon"
        image = gm(icon)
        image.resize imgData.w
        if imgData.h>imgData.w
          image.extent imgData.w, imgData.h
          image.in "-background", "transparent"
          targetDir += "newsstand-app-icon.imageset"
        else
          targetDir += "AppIcon.appiconset"
        writeImage image, imgData, targetDir
      else
        newImg = "tmpImg.png";
        newBg = "tmpBg.png";

        gm(logo)
        .resize(imgData.w / 3)
        .write process.cwd()+'/public/files/'+newImg, ->
          gm(background)
          .crop(imgData.w, imgData.h, (1024-imgData.w / 2), (1024-imgData.h / 2))
          .write process.cwd()+'/public/files/'+newBg, ->
            console.log "new bg done.........................."
            if format is "shelf"
              if imgData.n.indexOf("portrait")>1 then targetDir += "shelf-bg-portrait.imageset"
              else targetDir += "shelf-bg-landscape.imageset"
            else if format is "launch"
              targetDir += "LaunchImage.launchimage"
            image
              .in('-page', '+0+0').in(process.cwd()+'/public/files/'+newBg)
              .in('-page', '+'+((imgData.w-imgData.w/3)/2)+'+'+((imgData.h-imgData.h/4)/3)+'')
              .in(process.cwd()+'/public/files/'+newImg).flatten()
            writeImage image, imgData, targetDir

    # write the image
    writeImage = (image, imgData, targetDir) ->
      targetImageLink = targetDir+"/"+imgData.n+".png"
      console.log targetImageLink
      image.write targetImageLink, (err)->
        if err then return console.error("WriteImage error...",err)
        # check if icon variation is left
        if iconInfos.length>0 then createIcon iconInfos.pop()
        else
          # check if format variation is left
          if formats.length>0 then createIcons formats.pop()
          # else all done
          else cb()

    # start it up
    createIcon iconInfos.pop()
  return