StaticBlock = require __dirname+'/model/StaticBlockSchema'
fs = require "fs-extra"

module.exports.setup = (app)->

	# Insert Frontend Layout Data
	StaticBlock.count {}, (err, count)->
		if count is 0
      spawn = require('child_process').spawn
      mongoimport = spawn 'mongoimport', ['--db', 'publish', '--collection', 'staticblocks', '--file', 'staticblocks.json'], cwd:__dirname+'/data/'

  # get single static block data
	app.get '/StaticBlock/:id', (req, res)->
    StaticBlock.findOne key:req.params.id, (e, a)-> res.send a.data

  # export StaticBlock
	app.get '/exportStaticBlocks', (req, res)->
    if fs.existsSync __dirname+'/data/staticblocks.json' then fs.unlinkSync __dirname+'/data/staticblocks.json'
    spawn = require('child_process').spawn
    mongoexport = spawn('mongoexport', ['-d', 'publish', '-c', 'staticblocks', '-o', 'staticblocks.json'], cwd:__dirname+'/data/').on 'exit', (code)->
      if code is 0
      	res.send("Exported Static Blocks")
      	console.log("Exported Static Blocks")
      else
        res.send('Error: while exporting Static Blocks, code: ' + code)
        console.log('Error: while exporting Static Blocks, code: ' + code)

	# crud
	app.get '/StaticBlocks', (req, res)->
    StaticBlock.find().limit(20).execFind (arr,data)-> res.send data

	app.post '/StaticBlocks', (req, res)->
		a = new StaticBlock
		a.title = req.body.title
		a.key = req.body.key
		a.data = req.body.data
		a.deleteable = req.body.deleteable
		a.save -> res.send a

	app.put '/StaticBlocks/:id', (req, res)->
		StaticBlock.findById req.params.id, (e, a)->
			a.title = req.body.title
			a.key = req.body.key
			a.data = req.body.data
			a.deleteable = req.body.deleteable
			a.save -> res.send a

	app.delete '/StaticBlocks/:id', (req, res)->
    StaticBlock.findById req.params.id, (e, a)->
      a.remove -> res.send 'deleted static block'

