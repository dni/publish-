Article = require __dirname+'/model/ArticleSchema'

module.exports.setup = (app)->

	app.get '/articles', (req, res)->
    Article.find().limit(20).execFind (arr,data)->
      res.send data

	app.post '/articles', (req, res)->
		a = new Article
		a = req.body
		a.user = app.user.id
		a.title = req.body.title
		a.desc = req.body.desc
		a.author = req.body.author
		a.images = req.body.images
		a.published = req.body.published
		a.category = req.body.category
		a.tags = req.body.tags
		a.date = new Date()
		a.save ->
			req.io.broadcast 'updateCollection', 'Articles'
			res.send a

	app.put '/articles/:id', (req, res)->
		Article.findById req.params.id, (e, a)->
			a.title = req.body.title
			a.desc = req.body.desc
			a.author = req.body.author
			a.images = req.body.images
			a.published = req.body.published
			a.category = req.body.category
			a.tags = req.body.tags
			a.date = new Date()
			a.save ->
				req.io.broadcast 'updateCollection', 'Articles'
				res.send a

	app.delete '/articles/:id', (req, res)->
		Article.findById req.params.id, (e, a)->
  		a.remove (err)->
  			if !err
  				req.io.broadcast 'updateCollection', 'Articles'
  				res.send ''
  			else
          console.log err



