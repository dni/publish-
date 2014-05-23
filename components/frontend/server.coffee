express = require 'express'
Article = require process.cwd()+'/components/backend/modules/article/model/ArticleSchema'
File = require process.cwd()+'/components/backend/modules/files/model/FileSchema'
Blocks = require process.cwd()+'/components/backend/modules/static/model/StaticBlockSchema'
async = require 'async'

module.exports.setup = (app)->

	app.use '/', express.static __dirname

	# web app
	app.get '/', (req, res) -> res.sendfile __dirname+'/index.html'

  # static block
	app.get '/blocks', (req,res)->
		Blocks.find(
		  'key':
        $in: req.query.blocks
		).execFind (err, data)->
			res.send data

  # articles
	app.get '/publicarticles', (req,res)->
    Article.find(published: true).execFind (err, articles)->
      calls = []
      for article in articles
        article.files = []
        calls.push (cb)->
          console.log "hello", article
          File.find(relation:'article:'+article._id).execFind (err, files)->
            if err then return
            for file in files
              article.files.push file
            cb()

      async.parallel calls, ->
        res.send articles
