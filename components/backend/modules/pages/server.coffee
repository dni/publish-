Page = require(__dirname + "/model/PageSchema")
fs = require("fs-extra")
auth = require './../../utilities/auth'

module.exports.setup = (app) ->

  app.get "/pages", auth, (req, res) ->
    if req.query.magazine
      Page.find(magazine: req.query.magazine).execFind (arr, data) ->
        res.send data
    else
      Page.find(magazine: '').execFind (arr, data) ->
        res.send data

  app.post "/pages", auth, (req, res) ->
    a = new Page()
    a.magazine = req.body.magazine
    a.article = req.body.article
    a.number = req.body.number
    a.layout = req.body.layout
    a.published = req.body.published
    a.title = req.body.title
    a.save -> res.send a

  app.put "/pages/:id", auth, (req, res) ->
    Page.findById req.params.id, (e, a) ->
      a.magazine = req.body.magazine
      a.article = req.body.article
      a.number = req.body.number
      a.layout = req.body.layout
      a.published = req.body.published
      a.title = req.body.title
      a.save -> res.send a

  app.delete '/pages/:id', auth, (req, res)->
    Page.findById req.params.id, (e, model)->
      model.remove -> res.send 'page deleted'


