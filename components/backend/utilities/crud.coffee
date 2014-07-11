auth = require "./auth"

module.exports = (app, config)->
  Schema = require('./../lib/model/Schema')(config.dbTable)

    # crud

  console.log(config)

  app.post '/'+config.urlRoot, auth, (req, res)->
    schema = new Schema
    schema.user = app.user._id
    schema.crdate = new Date()
    schema.date = new Date()
    schema.name = req.body.name
    schema.fields = req.body.fields
    schema.save -> res.send schema

  app.get '/'+config.urlRoot, auth, (req, res)->
    Schema.find().limit(20).execFind (arr,data)-> res.send data

  app.put '/'+config.urlRoot+'/:id', auth, (req, res)->
    Schema.findById req.params.id, (e, schema)->
      schema.date = new Date()
      schema.fields = req.body.fields
      schema.save -> res.send schema

  app.delete '/'+config.urlRoot+'/:id', auth, (req, res)->
    Schema.findById req.params.id, (e, a)->
      a.remove -> res.send 'deleted'

  console.log JSON.stringify app.routes
