express = require 'express'
_ = require 'underscore'

Article = require process.cwd()+'/components/backend/modules/article/model/ArticleSchema'
File = require process.cwd()+'/components/backend/modules/files/model/FileSchema'
Blocks = require process.cwd()+'/components/backend/modules/static/model/StaticBlockSchema'
async = require 'async'

module.exports.setup = (app)->

	app.use'/', express.static __dirname

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
		Article.find({'published': true}).execFind (err,data)->
			calls = []
      data.forEach (article)->
				article.files = []
        calls.push (callback)->
          File.find({ 'relation': 'article:'+article._id}).execFind (arr,data)->
						data.forEach (file)->
							article.files.push file
          callback null, article

			async.parallel calls, (err, result)->
				res.send result

