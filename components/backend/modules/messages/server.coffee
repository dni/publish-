Message = require __dirname + "/model/Schema"
fs = require "fs"
auth = require './../../utilities/auth'

module.exports.setup = (app) ->

  app.get "/messages", auth, (req, res) ->
    limit = if req.query.limit? then req.query.limit else 25
    Message.find().sort(date: -1).limit(limit).execFind (arr, data) ->
      res.send data

  app.post "/messages", auth, (req, res) ->
    message = new Message()
    message.date = req.body.date
    message.message = req.body.message
    message.username = req.body.username
    message.additionalinfo = req.body.additionalinfo
    message.type = req.body.type

    # log every message
    console.log message
    message.save ->
      req.io.broadcast "updateCollection", "Messages"
      req.io.broadcast "message", message
      res.send message

