config = require "./configuration.json"

port = process.argv[2] || config.developmentPort
sessionSecret = 'publish#crossplattform#app'

express = require 'express.io'
app = express()
passport = require "passport"
LocalStrategy = require('passport-local').Strategy
mongoose = require "mongoose"
Users = require __dirname+"/components/backend/modules/user/model/UserSchema"
db = mongoose.connect 'mongodb://localhost/'+config.dbname
fs = require 'fs'

app.http().io()

app.configure ->

  #authentication
  passport.use new LocalStrategy (username, password, done) ->
    Users.findOne(
      username: username
      password: password
    ).execFind (err, user)->
      done err, user[0]

  passport.serializeUser (user, done) ->
    done null, user._id

  passport.deserializeUser (_id, done)->
    Users.findById _id, (err, user)->
      if !err then app.user = user
      done(err, user)

  app.use '/public', express.static 'public'
  app.use express.json()
  app.use express.urlencoded()
  app.use express.cookieParser()
  app.use express.session secret: sessionSecret
  app.use passport.initialize()
  app.use passport.session()



# load/setup components
componentsDir = __dirname+'/components/'
fs.readdir componentsDir, (err, files)->
  if err then throw err
  files.forEach (file)->
    fs.lstat componentsDir+file, (err, stats)->
      if !err && stats.isDirectory()
        fs.exists componentsDir+file+'/server.coffee', (exists)->
          if exists
            component = require componentsDir+file+'/server.coffee'
            component.setup app


app.listen port
console.log "Welcome to Publish! server runs on port "+port