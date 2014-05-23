Magazine = require(__dirname + "/model/MagazineSchema")
Page = require(__dirname + "/model/PageSchema")
fs = require("fs-extra")
PrintGenerator = require(__dirname + "/generators/PrintGenerator")
HpubGenerator = require(__dirname + "/generators/HpubGenerator")


module.exports.setup = (app) ->
  app.get "/downloadPrint/:title", PrintGenerator.download

  app.get "/magazines", (req, res) ->
    Magazine.find().limit(20).execFind (arr, data) ->
      res.send data

  app.post "/magazines", (req, res) ->
    a = new Magazine()
    a.user = app.user.id
    a.editorial = req.body.editorial
    a.impressum = req.body.impressum
    a.cover = req.body.cover
    a.back = req.body.back
    a.author = req.body.author
    a.product_id = req.body.product_id
    a.info = req.body.info
    a.published = req.body.published
    a.papersize = req.body.papersize
    a.orientation = req.body.orientation
    a.files = req.body.files
    a.date = new Date()
    a.title = req.body.title
    a.save ->
      createMagazineFiles req.body.title, ->
        HpubGenerator.generate a
      #shortcut
      res.send a

  app.put "/magazines/:id", (req, res) ->
    Magazine.findById req.params.id, (e, a) ->
      child_process = require("child_process").spawn
      spawn = child_process("rm", ["-r", a.title], cwd: "./public/books/")
      spawn.on "exit", (code) ->
        if code isnt 0
          res.send a
          console.log "remove Magazine " + a.title + " exited with code " + code
        else
          console.log "removed Magazine Files: " + req.body.title
          a.editorial = req.body.editorial
          a.impressum = req.body.impressum
          a.cover = req.body.cover
          a.back = req.body.back
          a.author = req.body.author
          a.product_id = req.body.product_id
          a.info = req.body.info
          a.published = req.body.published
          a.papersize = req.body.papersize
          a.orientation = req.body.orientation
          a.files = req.body.files
          a.date = new Date()
          a.title = req.body.title
          a.save ->
            console.log "created Magazine Files: " + a.title
            createMagazineFiles req.body.title, ->
              HpubGenerator.generate a
            res.send a

  app.get "/pages", (req, res) ->
    res.send "no magazine id"  unless req.query.magazine
    Page.find(magazine: req.query.magazine).execFind (arr, data) ->
      res.send data

  app.post "/pages", (req, res) ->
    a = new Page()
    a.magazine = req.body.magazine
    a.article = req.body.article
    a.number = req.body.number
    a.layout = req.body.layout
    a.save -> res.send a

  app.put "/pages/:id", (req, res) ->
    Page.findById req.params.id, (e, a) ->
      a.magazine = req.body.magazine
      a.article = req.body.article
      a.number = req.body.number
      a.layout = req.body.layout
      a.save -> res.send a

  app.delete '/magazines/:id', (req, res)->
    Magazine.findById req.params.id, (e, a)->
      a.remove ->
        spawn = require('child_process').spawn('rm', ['-rf', '-', a.title], {cwd:process.cwd()+'/public/books/'})
  	    spawn.on 'exit', (code)->
          if code is 0 then res.send 'deleted'
          else
            res.statusCode = 500;
            console.log('remove book/yourmagazine (rm) process exited with code ' + code);

  app.delete '/pages/:id', (req, res)->
    Page.findById req.params.id, (e, model)->
      model.remove (err)->
      if !err then return res.send '' else console.log err

createMagazineFiles = (folder, cb) ->
  fs.mkdirSync "./public/books/" + folder
  fs.copySync "./components/magazine/gfx", "./public/books/" + folder + "/hpub/gfx"
  fs.copySync "./components/magazine/css", "./public/books/" + folder + "/hpub/css"
  fs.copySync "./components/magazine/js", "./public/books/" + folder + "/hpub/js"
  fs.copySync "./components/magazine/images", "./public/books/" + folder + "/hpub/images"
  cb()

