gm = require "gm"
fs = require "fs-extra"
completeSizeList = require "./AppAssets"
File = require "./../../files/model/FileSchema"
extend = require('util')._extend

module.exports = (setting, cb)->
  sizeList = completeSizeList()
  formats = ["shelf", "launch", "icon"]
  icon= ''
  background= ''
  logo= ''
  File.find(relation: 'setting:'+setting._id).exec (err, files)->
    if err then return
    if files.length != 0
      for i, file of files
        if file.key is 'background' then background = process.cwd()+'/public/files/'+file.name
        if file.key is 'logo' then logo = process.cwd()+'/public/files/'+file.name
        if file.key is 'icon' then icon = process.cwd()+'/public/files/'+file.name

    if background is "" then background = __dirname+'/templates/bg.jpg'
    if logo is "" then logo = __dirname+'/templates/logo.png'
    if icon is "" then icon = __dirname+'/templates/icon.png'
    createIcons formats.pop()

  createIcons = (format)->
    #key = if format is "icon" then "icon" else "logo"
    #size = if key is "logo" then width:1024,height:640 else width:286,height:286
    image = gm()

    iconInfos = sizeList[format]
    createIcon = (imgData)->
      targetDir = process.cwd()+'/cache/publish-baker/Baker/BakerAssets.xcassets/'
      if format is "icon"
        image = gm(icon)
        image.resize imgData.w
        # newstand workaround
        image.in "-gravity", "center"
        if imgData.h>imgData.w
          image.extent imgData.w, imgData.h
          targetDir += "newsstand-app-icon.imageset"

        # icon
        else
          image.extent imgData.w, imgData.h
          image.in "-background", "transparent"
          targetDir += "AppIcon.appiconset"

        writeImage image, imgData, targetDir
      else
        newImg = "tmpImg.png"
        newBg = "tmpBg.png"
        gm(logo).size( (err, value)->
          if value.width < imgData.w/3
            sizeOfLogo = value.width
            heightOfLogo = value.height
          else if value.width > imgData.w/3
            sizeOfLogo = imgData.w/3
            heightOfLogo = (imgData.w/3)*(640/1024)
          gm(logo).resize(sizeOfLogo).write process.cwd()+'/public/files/'+newImg, ->
            gm(background)
            .crop(imgData.w, imgData.h, (1024-imgData.w / 2), (1024-imgData.h / 2))
            .write process.cwd()+'/public/files/'+newBg, ->
              if format is "shelf"
                topPos = imgData.h/10
                if imgData.n.indexOf("portrait")>1 then targetDir += "shelf-bg-portrait.imageset"
                else targetDir += "shelf-bg-landscape.imageset"
              else if format is "launch"
                topPos = (imgData.h/2)-heightOfLogo
                targetDir += "LaunchImage.launchimage"
              else topPos = (imgData.h/2)-heightOfLogo
              image
                .in('-page', '+0+0').in(process.cwd()+'/public/files/'+newBg)
                .in('-page', '+'+((imgData.w/2)-sizeOfLogo/2)+'+'+topPos)
                .in(process.cwd()+'/public/files/'+newImg).flatten()
              writeImage image, imgData, targetDir
        )

    # write the image
    writeImage = (image, imgData, targetDir) ->
      targetImageLink = targetDir+"/"+imgData.n+".png"
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