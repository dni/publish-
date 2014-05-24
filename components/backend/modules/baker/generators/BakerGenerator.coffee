fs = require("fs-extra")
gm = require("gm")
File = require("./../../files/model/FileSchema")
emitter = require("events").EventEmitter
ejs = require("ejs")
EE = new emitter()
FileList = require('./AppIcons');
Settings = require("./../../settings/model/SettingSchema")
StaticBlocks = require("./../../static/model/StaticBlockSchema")

module.exports.download = (req, res) ->
  EE.removeAllListeners "ready"
  tasks = ["icon","build","constants"]
  EE.on "ready", (task) ->
    tasks.splice tasks.indexOf(task), 1
    unless tasks.length
      spawn = require("child_process").spawn
      zip = spawn("zip", ["-r","-","publish-baker"],cwd: "./cache")
      res.contentType "zip"
      zip.stdout.on "data", (data) -> res.write data
      zip.on "close", (code) ->
        if code is 0 then console.log "download app zip done" else console.log "download app zip exited with code " + code
        res.end()

  Settings.findOne(name: "Baker").exec (error, setting) ->

    # delete dirty baker project
    spawn = require("child_process").spawn("rm", ["-rf", "-", "publish-baker"], cwd: process.cwd() + "/cache")
    spawn.on "exit", (code) ->
      if code isnt 0
        console.log "remove cache/publish-baker (rm) process exited with code " + code
      else
        dirname = process.cwd() + "/cache/publish-baker"
        fs.copySync process.cwd() + "/baker-master", dirname

        # start image generating
        startGenIconssets setting

        # if standalone copy all hpubs into baker project
        if setting.settings.apptype.value is "standalone"
          files = fs.readdirSync("./public/books")
          for key of files
            file = files[key]
            continue if file is ".DS_Store" || ".gitignore"
            fs.copySync "./public/books/" + file + "/hpub", dirname + "/books/" + file

        Settings.findOne(name: "General").exec (error, generalsetting) ->

          # Constants
          template = fs.readFileSync(__dirname + "/templates/Constants.h", "utf-8")
          fs.writeFileSync dirname + "/BakerShelf/Constants.h", ejs.render template,
            settings: setting.settings
            domain: generalsetting.settings.domain.value

          # Ui constants
          template = fs.readFileSync(__dirname + "/templates/UIConstants.h", "utf-8")
          fs.writeFileSync dirname + "/BakerShelf/UIConstants.h", ejs.render template,
            settings: setting.settings

          # Baker-Info.plist
          template = fs.readFileSync(__dirname + "/templates/Baker-Info.plist", "utf-8")
          fs.writeFileSync dirname + "/Baker/Baker-Info.plist", ejs.render template,
            settings: setting.settings
            domain: generalsetting.settings.domain.value

          # info menu
          StaticBlocks.findOne(key: "info").exec (err, block) ->
            template = fs.readFileSync(__dirname + "/templates/info.html", "utf-8")
            fs.writeFileSync dirname + "/BakerShelf/info/info.html", ejs.render template,
              block: block.data

          EE.emit "ready", "constants"

        EE.emit "ready", "build"

writeImage = (image) ->
  targetImageLink = targetDir +"/"+ imgData.n +"."+ filetype
  image.write targetImageLink, (err)->
    if err then return console.error("icon.write err=", err)
    # check if icon variation is left
    if iconInfos.length>0 then createIcon iconInfos.pop()
    else
      # check if format variation is left
      if formats.length>0 then createIcons formats.pop()
      # else all done
      else EE.emit('ready', 'icon')

createIcons = (format)->
  key = if format is "icon" then "icon" else "logo"
  size = if key is "logo" then width:1024,height:768 else width:286,height:286
  image = gm()
  filetype = "png"
  iconInfos = sizeList[format]

createIcon = (imgData)->
  targetDir = './cache/publish-baker/Baker/BakerAssets.xcassets/'
  if format is "icon"
    image = gm('./public/files/'+ icon)
    image.resize imgData.w
    if imgData.h>imgData.w
      image.extent imgData.w, imgData.h
      image.in "-background", "transparent"
      targetDir += "newsstand-app-icon.imageset"
    else
      targetDir += "AppIcon.appiconset"
    writeImage(image)
  else
    newImg = "tmpImg."+logo.split(".").pop()
    newBg = "tmpBg."+background.split(".").pop()
    gm('./public/files/'+ logo).resize(imgData.w/3).write './public/files/'+newImg, ->
      gm(background).crop(imgData.w, imgData.h, (1024-imgData.w/2), (1024-imgData.h/2)).write './public/files/'+newBg, ->
        if format is "shelf"
          if imgData.n.indexOf("portrait")>1 then targetDir += "shelf-bg-portrait.imageset" else targetDir += "shelf-bg-landscape.imageset"
        else if format is "launch"
          targetDir += "LaunchImage.launchimage"
        image
          .in('-page', '+0+0').in('./public/files/'+ newBg)
          .in('-page', '+'+((imgData.w-imgData.w/3)/2)+'+'+((imgData.h-imgData.h/4)/3)+'')
          .in('./public/files/'+ newImg).flatten()

        writeImage image
