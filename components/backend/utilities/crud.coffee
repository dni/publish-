auth = require "./auth"

module.exports = (app, config)->
  Schema = require('./../lib/model/Schema')(config.dbTable)

    # crud
  app.post config.url, auth, (req, res)->
    schema = new Schema
    schema.user = app.user._id
    schema.crdate = new Date()
    schema.date = new Date()
    schema.attributes = req.body
    schema.save -> res.send schema

  app.get config.url, auth, (req, res)->
    Schema.find().limit(20).execFind (arr,data)-> res.send data

  app.put config.url+':id', auth, (req, res)->
    Schema.findById req.params.id, (e, schema)->
      schema.date = new Date()
      schema.attributes = req.body
      schema.save -> res.send schema

  app.delete config.url+':id', auth, (req, res)->
    Schema.findById req.params.id, (e, a)->
      a.remove -> res.send 'deleted'