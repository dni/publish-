Setting = require __dirname+'/model/SettingSchema'

module.exports.setup = (app)->

  # clear cache /rebuild
  app.get "/clearCache", (req, res) ->
    grunt = require("child_process").spawn("grunt", ["build"])
    grunt.on "end", ->
      res.send "cache cleared"

  # crud
  app.get "/settings", (req, res) ->
    Setting.find().execFind (arr, data) ->
      res.send data

  app.post "/settings", (req, res) ->
    s = new Setting()
    s.name = req.body.name
    s.settings = req.body.settings
    s.save -> res.send s


  app.put "/settings/:id", (req, res) ->
    Setting.findById req.params.id, (e, s) ->
      s.name = req.body.name
      s.settings = req.body.settings
      # build = require("./components/backend/utilities/build.js")  if req.body.development and req.body.development.value
      s.save -> res.send s

  app.delete '/settings/:id', (req, res)->
    Setting.findById req.params.id, (e, a)->
      a.remove (err)-> if !err then res.send 'deleted' else console.log err