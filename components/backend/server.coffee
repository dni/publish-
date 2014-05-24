fs = require 'fs'
module.exports.setup = (app)->
	app.configure ->
		dir =  __dirname+'/modules/'
		fs.readdir dir, (err, files)->
      if err then throw err
      files.forEach (file)->
        fs.lstat dir+file, (err, stats)->
          if !err && stats.isDirectory()
            fs.exists dir+file+'/server.coffee', (exists)->
              if exists
                module = require dir+file+'/server.coffee'
                module.setup app
            fs.exists dir+file+'/server.js', (exists)->
              if exists
                module = require dir+file+'/server.js'
                module.setup app