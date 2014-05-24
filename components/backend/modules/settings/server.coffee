Setting = require __dirname+'/model/SettingSchema'
auth = require './../../utilities/auth'

module.exports.setup = (app)->

  # clear cache /rebuild
  app.get "/clearCache", auth, (req, res) ->
    grunt = require("child_process").spawn("grunt", ["build"])
    grunt.on "end", ->
      res.send "cache cleared"

  # crud
  app.get "/settings", auth, (req, res) ->
    Setting.find().execFind (arr, data) ->
      res.send data

  app.post "/settings", auth, (req, res) ->
    s = new Setting()
    s.name = req.body.name
    s.settings = req.body.settings
    s.save -> res.send s


  app.put "/settings/:id", auth, (req, res) ->
    Setting.findById req.params.id, (e, s) ->
      s.name = req.body.name
      s.settings = req.body.settings
      # build = require("./components/backend/utilities/build.js")  if req.body.development and req.body.development.value
      s.save -> res.send s

  app.delete '/settings/:id', auth, (req, res)->
    Setting.findById req.params.id, (e, a)->
      a.remove (err)-> if !err then res.send 'deleted' else console.log err