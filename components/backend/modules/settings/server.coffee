Setting = require __dirname+'/model/SettingSchema'
auth = require './../../utilities/auth'

module.exports.setup = (app)->

  # clear cache /rebuild
  app.get "/clearCache", auth, (req, res) ->
    # grunt = require("child_process").spawn("grunt", ["reloadSettings"])
    # #grunt = require('grunt').tasks(['build']);
    # grunt.stdout.on "data", (data) -> if data isnt "" then console.log "stdout: " + data
    # grunt.stderr.on "data", (data) -> console.log "stderr: " + data
    # #grunt.on "close", (code) -> console.log "child process closed with code " + code
    # grunt.on "close", (code) ->
    #     if code isnt 0
    #       res.statusCode = 500
    #       console.log "grunt process exited with code " + code
    #       res.end()
    #     else
    #       console.log "grunt task done without errors"
    #       res.end()
    exec = require("child_process").exec
    child = undefined
    child = exec("grunt restart", (error, stdout, stderr) ->
      console.log "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGG"
      console.log "stdout: " + stdout
      console.log "stderr: " + stderr
      console.log "exec error: " + error  if error isnt null
      res.end()
    )

    


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