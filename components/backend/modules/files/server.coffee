File = require __dirname+'/model/FileSchema'
Setting = require './../settings/model/SettingSchema'
auth = require './../../utilities/auth'
gm = require 'gm'
multiparty = require "multiparty"
fs = require "fs"

module.exports.setup = (app)->
  app.post "/uploadFile", auth, (req,res)->

    form = new multiparty.Form
    form.parse req, (err, fields, files)->
      if err then return console.log 'formparse error', err
      files['files[]'].forEach (srcFile)->
        file = new File()
        name = srcFile.originalFilename
        targetLink = "./public/files/" + name
        if fs.existsSync(targetLink) is true
          name = "copy_" + Date.now() + "_" + name
          targetLink = "./public/files/" + name
        file.name = name
        file.type = srcFile.headers['content-type']
        file.link = name
        fs.renameSync srcFile.path, targetLink

        if srcFile.headers['content-type'].split("/")[0] is "image"
          Setting.findOne(name: "Files").execFind (err, setting) ->
            cfg = setting.pop()
            createImages file, name, res, req, cfg
            return

        else
          file.save ->
            req.io.broadcast "updateCollection", "Files"
            res.send file
            return


    res.send "success"


  app.get '/files', auth, (req, res)->
    send = (arr, data)-> res.send(data)
    if req.query.parents
      File.find({'parent':undefined}).execFind send
    else
      File.find().execFind send

  app.post "/files", auth, (req, res) ->
    newfile = req.body
    file = new File()
    filename = "copy_" + Date.now() + "_" + newfile.name
    fs.writeFileSync "./public/files/" + filename, fs.readFileSync("./public/files/" + newfile.name)

    file.name = filename
    file.type = newfile.type
    file.link = filename
    file.info = newfile.info
    file.alt = newfile.alt
    file.desc = newfile.desc
    file.parent = newfile.parent
    file.relation = newfile.relation
    file.key = newfile.key

    if newfile.type.split("/")[0] is "image"
      Setting.findOne(name: "Files").execFind (err, setting) ->
        cfg = setting.pop()
        createImages file, filename, res, req, cfg

    else
      file.save ->
        req.io.broadcast "updateCollection", "Files"
        res.send file

  app.delete '/files/:id', auth, (req, res)->
    File.findById req.params.id, (e, a)->
      a.remove (err)->
        if err then return res.send "error while removing file "+a.name
        if fs.existsSync "./public/files/"+a.name then fs.unlink "./public/files/"+a.name
        res.send 'removing file '+a.name

  app.put '/files/:id', auth, (req, res)->
    File.findById req.params.id, (e, a)->
      if req.body.crop
        # TODO crop picture with ratio
        console.log req.body.crop
        #done, do not do the usual edit stuff
        res.end()
      name = req.body.name
      # rename file if name changes
      if a.name != name
        link = './public/files/' + a.name
        targetLink = './public/files/' + name
        if fs.existsSync(targetLink) is true
          name = 'copy_'+Date.now()+'_'+ name
          targetLink = './public/files/' + name
        fs.renameSync link, targetLink
        a.link = name
      a.name = name
      a.info = req.body.info
      a.alt = req.body.alt
      a.desc = req.body.desc
      a.parent = req.body.parent
      a.relation = req.body.relation
      a.key = req.body.key
      a.save ->
        req.io.broadcast 'updateCollection', 'Files'

createImages = (file, filename, res, req, cfg) ->
  shrinkPic = (type, size) ->
    maxSize = cfg.settings[type].value
    targetName = type + filename
    file[type] = targetName
    targetLink = "./public/files/" + targetName
    image.quality parseInt(cfg.settings.quality.value)
    if size.width > size.height
      image.resize maxSize
    else
      image.resize null, maxSize
    image.write targetLink, (err) ->
      if err then return console.error "image.write('./public/files/iconset/ err=", err
      if types.length > 0
        shrinkPic types.pop(), size
      else
        file.save ->
          req.io.broadcast "updateCollection", "Files"
          res.send file

  types = [
    "thumbnail"
    "smallPic"
    "bigPic"
  ]
  image = gm("./public/files/" + filename)
  image.size (err, size) ->
    if err then return console.error "createWebPic getSize err=", err
    shrinkPic types.pop(), size
