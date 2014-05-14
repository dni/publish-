fs = require 'fs'
module.exports.setup = (app)->
	app.configure ->
		# load/setup modules
		fs.readdir '#{__dirname}/modules/', (err, files)->
		  if err throw err
      files.forEach (file)->
        fs.lstat '#{__dirname}/modules/#{file}', (err, stats)->
          if !err && stats.isDirectory()
            fs.exists '#{__dirname}/modules/#{file}/server.js', (exists)->
  				    if exists
                module = require '#{__dirname}/modules/#{file}/server.js'
                module.setup app