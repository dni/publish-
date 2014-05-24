StaticBlocks = require __dirname+'/model/StaticBlockSchema'
fs = require "fs-extra"

module.exports.setup = (app)->

	# Insert Frontend Layout Data
	StaticBlocks.count {}, (err, count)->
		if count == 0
      mongoimport = require('child_process').spawn('mongoimport', ['--db', 'publish', '--collection', 'staticblocks', '--file', 'staticblocks.json'], {cwd:__dirname+'/data/'})

  # get single static block data
	app.get '/staticBlocks/:id', (req, res)->
    StaticBlocks.findOne key:req.params.id, (e, a)-> res.send a.data

  # export staticblocks
	app.get '/exportStaticBlocks', (req, res)->
		if fs.existsSync __dirname+'/data/publish/staticblocks.json' then fs.unlinkSync __dirname+'/data/publish/staticblocks.json'
		mongoimport = require('child_process').spawn('mongoexport', ['-d', 'publish', '-c', 'staticblocks', '-o', 'staticblocks.json'], {cwd:__dirname+'/data'})
		mongoimport.on 'exit', (code)->
      if code is 0
        res.send('Error: while exporting Static Blocks, code: ' + code)
        console.log('Error: while exporting Static Blocks, code: ' + code)
      else
      	res.send("Exported Static Blocks")
      	console.log("Exported Static Blocks")

	# crud
	app.get '/staticBlocks', (req, res)->
    StaticBlocks.find().limit(20).execFind (arr,data)-> res.send data

	app.post '/staticBlocks', (req, res)->
		a = new StaticBlock
		a.title = req.body.title
		a.key = req.body.key
		a.data = req.body.data
		a.deleteable = req.body.deleteable
		a.save -> res.send a

	app.put '/staticBlocks/:id', (req, res)->
		StaticBlock.findById req.params.id, (e, a)->
			a.title = req.body.title
			a.key = req.body.key
			a.data = req.body.data
			a.deleteable = req.body.deleteable
			a.save -> res.send a

	app.delete '/staticBlocks/:id', (req, res)->
	    StaticBlock.findById req.params.id, (e, a)->
        a.remove (err)->
          if !err then res.send 'deleted' else console.log err

