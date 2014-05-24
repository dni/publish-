User = require __dirname+'/model/UserSchema'
Setting = require process.cwd()+'/components/backend/modules/settings/model/SettingSchema'
express = require 'express'
auth = require "../../utilities/auth"
passport = require 'passport'

module.exports.setup = (app)->

	# login
	app.get '/login', (req, res)->
    res.sendfile process.cwd()+'/components/backend/modules/user/templates/login.html'

	app.post '/login', passport.authenticate('local', failureRedirect: '/login'), (req, res)->
    res.redirect '/admin'

	app.get '/logout', (req, res)->
	  req.logout()
	  res.redirect '/login'

  #admin route
	app.get '/admin', auth, (req, res)->
    Setting.find name:'General', (e, a)->
      # if setting doesnt exists start in development mode
      if a.length is 0 || a[0].settings.backend_development.value
        console.log "Starting backend in development mode"
        app.use '/admin', express.static process.cwd()+'/components/backend'
        app.use '/modules', express.static process.cwd()+'/components/backend/modules' # workaround for requirejs i18n problem with /admin
        res.sendfile process.cwd()+'/components/backend/index.html'
      else
        console.log "Starting backend in production mode"
        app.use '/admin', express.static process.cwd()+'/cache/build'
        app.use '/modules', express.static process.cwd()+'/cache/build/modules' # workaround for requirejs i18n problem with /admin
        res.sendfile process.cwd()+'/cache/build/index.html'

	app.get '/user', auth, (req, res)-> res.send app.user

  #crud
	app.get '/users', auth, (req, res)->
	  	User.find().limit(20).execFind (arr,data)->
	    	res.send data

  app.post '/users', auth, (req, res)->
    a = new User
    a.name = req.body.name
    a.username = req.body.username
    a.email = req.body.email
    a.role = req.body.role
    a.password = req.body.password
    a.save -> res.send a

	app.put '/users/:id', auth, (req, res)->
		User.findById req.params.id, (e, a)->
      a.name = req.body.name
      a.role = req.body.role
      a.username = req.body.username
      a.email = req.body.email
			a.password = req.body.password
			a.save -> res.send a

	app.delete '/users/:id', auth, (req, res)->
    User.findById req.params.id, (e, a)->
      a.remove (err)-> if !err then res.send 'deleted' else console.log err

  # create default admin user if no user exists
  User.count {}, (err, count)->
    if count == 0
      admin = new User
      admin.name = "Admin"
      admin.email = "admin@publish.org"
      admin.username = "admin"
      admin.password = "password"
      admin.role = 0
      admin.save()
      console.log "admin user was created"