Article = require __dirname+'/model/ArticleSchema'
auth = require "../../utilities/auth"

module.exports.setup = (app)->

  app.get '/articles', auth, (req, res)->
    Article.find().limit(20).execFind (arr,data)->
      res.send data

  app.post '/articles', auth, (req, res)->
    a = new Article
    a.user = app.user.id
    a.title = req.body.title
    a.desc = req.body.desc
    a.teaser = req.body.teaser
    a.author = req.body.author
    a.images = req.body.images
    a.published = req.body.published
    a.category = req.body.category
    a.tags = req.body.tags
    a.date = new Date()
    a.save ->
      req.io.broadcast 'updateCollection', 'Articles'
      res.send a

  app.put '/articles/:id', auth, (req, res)->
    Article.findById req.params.id, (e, a)->
      a.title = req.body.title
      a.desc = req.body.desc
      a.teaser = req.body.teaser
      a.author = req.body.author
      a.images = req.body.images
      a.published = req.body.published
      a.category = req.body.category
      a.tags = req.body.tags
      a.date = new Date()
      a.save ->
        req.io.broadcast 'updateCollection', 'Articles'
        res.send a

  app.delete '/articles/:id', auth, (req, res)->
    Article.findById req.params.id, (e, a)->
      a.remove (err)->
        if !err
          req.io.broadcast 'updateCollection', 'Articles'
          res.send ''
        else
          console.log err
