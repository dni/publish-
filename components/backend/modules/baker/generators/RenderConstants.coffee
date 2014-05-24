ejs = require "ejs"
fs = require "fs-extra"
StaticBlocks = require "./../../static/model/StaticBlockSchema"
Settings = require "./../../settings/model/SettingSchema"

module.exports = (setting, cb)->
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

    cb()
