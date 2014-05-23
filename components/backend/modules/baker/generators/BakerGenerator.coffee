fs = require("fs-extra")
gm = require("gm")
File = require("./../../files/model/FileSchema")
emitter = require("events").EventEmitter
ejs = require("ejs")
EE = new emitter()
Settings = require("./../../settings/model/SettingSchema")
StaticBlocks = require("./../../static/model/StaticBlockSchema")

module.exports.download = (req, res) ->
  EE.removeAllListeners "ready"
  tasks = [
    "icon"
    "build"
    "constants"
  ]
  EE.on "ready", (task) ->
    tasks.splice tasks.indexOf(task), 1
    unless tasks.length
      spawn = require("child_process").spawn
      zip = spawn("zip", [
        "-r"
        "-"
        "publish-baker"
      ],
        cwd: "./cache"
      )
      res.contentType "zip"
      zip.stdout.on "data", (data) ->
        res.write data

      zip.stderr.on "data", (data) ->
      zip.on "close", (code) ->
        if code isnt 0
          console.log "zip process exited with code " + code
          res.end()
        else
          console.log "download app zip done"
          res.end()

  prepareDownload()

prepareDownload = ->
  Settings.findOne(name: "Baker").exec (error, setting) ->

    # delete dirty baker project
    child_process = require("child_process").spawn
    spawn = child_process("rm", ["-rf", "-", "publish-baker"], cwd: process.cwd() + "/cache")
    spawn.on "exit", (code) ->
      if code isnt 0
        console.log "remove cache/publish-baker (rm) process exited with code " + code
      else
        dirname = process.cwd() + "/cache/publish-baker"
        fs.copySync process.cwd() + "/baker-master", dirname
        startGenIconssets setting
        Settings.findOne(name: "General").exec (error, generalsetting) ->

          # Constants
          template = fs.readFileSync(__dirname + "/templates/Constants.h", "utf-8")
          fs.writeFileSync dirname + "/BakerShelf/Constants.h", ejs.render(template,
            settings: setting.settings
            domain: generalsetting.settings.domain.value
          )

          # Ui constants
          template = fs.readFileSync(__dirname + "/templates/UIConstants.h", "utf-8")
          fs.writeFileSync dirname + "/BakerShelf/UIConstants.h", ejs.render(template,
            settings: setting.settings
          )

          # Baker-Info.plist
          template = fs.readFileSync(__dirname + "/templates/Baker-Info.plist", "utf-8")
          fs.writeFileSync dirname + "/Baker/Baker-Info.plist", ejs.render(template,
            settings: setting.settings
            domain: generalsetting.settings.domain.value
          )

          # info menu
          StaticBlocks.findOne(key: "info").exec (err, block) ->
            if err throw (err)
            else
              template = fs.readFileSync(__dirname + "/templates/info.html", "utf-8")
              fs.writeFileSync dirname + "/BakerShelf/info/info.html", ejs.render(template,
                block: block.data
              )

          EE.emit "ready", "constants"

        action = setting.settings.apptype.value
        if action is "standalone"
          files = fs.readdirSync("./public/books")
          for key of files
            if files.hasOwnProperty(key)
              file = files[key]
              continue if file is ".DS_Store"
              continue if file is ".gitignore"
              fs.copySync "./public/books/" + file + "/hpub", dirname + "/books/" + file
        EE.emit "ready", "build"

createIcons = (format)->
  if format is "icon" then key="icon" else key="logo"
  if key is "logo" then size={width:1024,height:768} else size={width:286,height:286}
  targetImageLink = ""
  image = gm()
  filetype = "png"
  iconInfos = sizeList[format]


writeImage = (image) ->
  targetImageLink = targetDir +"/"+ imgData.n +"."+ filetype
  console.log format, imgData, imgData.n +"."+ filetype
  console.log background ,logo, icon
  image.write targetImageLink, (err)->
    if err then return console.error("icon.write err=", err)
    if iconInfos.length>0 then createIcon iconInfos.pop()
    else
      if formats.length>0 then createIcons formats.pop()
      else EE.emit('ready', 'icon')

createIcon = (imgData)->
  targetDir = './cache/publish-baker/Baker/BakerAssets.xcassets/'
  if format is "icon"
    image = gm('./public/files/'+ icon)
    if imgData.h>imgData.w
      image.resize imgData.w
      image.extent imgData.w, imgData.h
      image.in "-background", "transparent"
      targetDir += "newsstand-app-icon.imageset"
    else
      image.resize imgData.w
      targetDir += "AppIcon.appiconset"
    writeImage(image)
  else
    newImg = "tmpImg."+logo.split(".").pop()
    newBg = "tmpBg."+background.split(".").pop()
    gm('./public/files/'+ logo).resize(imgData.w/3).write './public/files/'+newImg, ->
      gm(background).crop(imgData.w, imgData.h, (1024-imgData.w/2), (1024-imgData.h/2)).write './public/files/'+newBg, ->
        if format is "shelf"
          image
            .in('-page', '+0+0').in('./public/files/'+ newBg)
            .in('-page', '+'+((imgData.w-imgData.w/3)/2)+'+'+((imgData.h-imgData.h/4)/3)+'')
            .in('./public/files/'+ newImg).flatten()
          if imgData.n.indexOf("portrait")>1 then targetDir += "shelf-bg-portrait.imageset"
          else targetDir += "shelf-bg-landscape.imageset"
          writeImage image
        else if format is "launch"
          image
            .in('-page', '+0+0').in('./public/files/'+ newBg)
            .in('-page', '+'+((imgData.w-imgData.w/3)/2)+'+'+((imgData.h-imgData.h/4)/3)+'')
            .in('./public/files/'+ newImg).flatten()
          targetDir += "LaunchImage.launchimage"
          writeImage image


getSizeList = ->
  icon :
    n: "iPad App iOS6", w: 72, h: 72
    n: "iPad App iOS6@2x", w: 144, h: 144
    n: "iPad App iOS7", w: 76, h: 76
    n: "iPad App iOS7@2x", w: 152, h: 152
    n: "iPhone App iOS6", w: 57, h: 57
    n: "iPhone App iOS6@2x", w: 114, h: 114
    n: "iPhone App iOS7@2x", w: 120, h: 120
    n: "newsstand-app-icon", w: 112, h: 126
    n: "newsstand-app-icon@2x", w: 224, h: 252
  launch :
    n: "iPad Landscape iOS6 no status bar", w: 1024, h: 748
    n: "iPad Landscape iOS6 no status bar@2x", w: 2048, h: 1496
    n: "iPad Landscape iOS7", w: 1024, h: 768
    n: "iPad Landscape iOS7@2x", w: 2048, h: 1536
    n: "iPad Portrait iOS6 no status bar", w: 768, h: 1004
    n: "iPad Portrait iOS6 no status bar@2x", w: 1536, h: 2008
    n: "iPad Portrait iOS7", w: 768, h: 1024
    n: "iPad Portrait iOS7@2x", w: 1536, h: 2048
    n: "iPhone Portrait iOS7 R4", w: 640, h: 1136
    n: "iPhone Portrait iOS7@2x", w: 640, h: 960
  shelf:
    n: "shelf-bg-landscape~iphone", w: 480, h: 268
    n: "shelf-bg-landscape-568h", w: 1136, h: 536
    n: "shelf-bg-landscape@2x~ipad", w: 2048, h: 1407
    n: "shelf-bg-landscape@2x~iphone", w: 960, h: 536
    n: "shelf-bg-landscape~ipad", w: 1024, h: 704
    n: "shelf-bg-portrait-568h", w: 640, h: 1008
    n: "shelf-bg-portrait@2x~ipad", w: 1536, h: 1920
    n: "shelf-bg-portrait@2x~iphone", w: 640, h: 832
    n: "shelf-bg-portrait~ipad", w: 768, h: 960
    n: "shelf-bg-portrait~iphone", w: 320, h: 416
