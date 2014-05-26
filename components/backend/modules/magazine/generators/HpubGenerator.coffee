_ = require("underscore")
fs = require "fs-extra"
ejs = require("ejs")
PrintGenerator = require(__dirname + "/PrintGenerator")
Magazine = require("./../model/MagazineSchema")
Article = require("./../../article/model/ArticleSchema")
File = require("./../../files/model/FileSchema")
Settings = require("./../../settings/model/SettingSchema")
Page = require("./../model/PageSchema")

module.exports.generate = (magazine) ->

  Settings.findOne(name: "Magazines").execFind (err, file) ->
    print = if file[0].settings.print.value then true else false

    File.find(relation: "magazine:" + magazine._id).execFind (err, files) ->
      magazinefiles = {}
      _.each files, (file) ->
        fs.copy process.cwd() + "/public/files/" + file.name, process.cwd() + "/public/books/" + magazine.title + "/hpub/images/" + file.name
        magazinefiles[file.key] = file.name
        if file.key is 'cover' then fs.copy process.cwd() + "/public/files/" + file.name, process.cwd() + "/public/books/" + magazine.title + "/hpub/cover"+file.name.split(".").pop()

      # generage INDEX
      Page.find(magazine: magazine._id).exec (err, pages) ->
        articleIds = []
        _.each pages, (page) ->
          articleIds.push page.article

        Article.find(_id: $in: articleIds).execFind (err, articles) ->
          newarticles = {}
          _.each articles, (article) -> newarticles[article._id] = article.title

          template = fs.readFileSync("./components/magazine/index.html", "utf8")
          fs.writeFileSync "./public/books/" + magazine.title + "/hpub/index.html", ejs.render template,
            magazine: magazine
            pages: pages
            articles: newarticles

          PrintGenerator.generatePage "index.html", magazine if print

      # generate Cover
      template = fs.readFileSync("./components/magazine/Book Cover.html", "utf8")
      fs.writeFileSync "./public/books/" + magazine.title + "/hpub/Book Cover.html", ejs.render template,
        magazine: magazine
        cover: magazinefiles["cover"]

      #  generate Back
      template = fs.readFileSync("./components/magazine/Book Back.html", "utf8")
      fs.writeFileSync "./public/books/" + magazine.title + "/hpub/Book Back.html", ejs.render template,
        magazine: magazine
        back: magazinefiles["back"]

      # generate Impressum
      template = fs.readFileSync("./components/magazine/Tail.html", "utf8")
      fs.writeFileSync "./public/books/" + magazine.title + "/hpub/Tail.html", ejs.render template,
        magazine: magazine

      # generate Editorial
      template = fs.readFileSync("./components/magazine/Book Index.html", "utf8")
      fs.writeFileSync "./public/books/" + magazine.title + "/hpub/Book Index.html", ejs.render template,
        magazine: magazine

      if print
        PrintGenerator.generatePage "Book Cover.html", magazine
        PrintGenerator.generatePage "Book Back.html", magazine
        PrintGenerator.generatePage "Tail.html", magazine
        PrintGenerator.generatePage "Book Index.html", magazine

      # generate JSON
      files = fs.readdirSync("./public/books/" + magazine.title + "/hpub/")
      contents = []
      while file = files.pop()
        contents.push file if file.match(/.html/g)

      fs.writeFileSync "./public/books/" + magazine.title + "/hpub/book.json", JSON.stringify
        hpub: 1
        title: magazine.title
        author: [magazine.author]
        creator: [magazine.author]
        date: new Date()
        cover: "cover.jpg"
        url: "book://localhost:1666/public/books/" + magazine.title + "/hpub"
        orientation: "both"
        zoomable: false
        "-baker-background": "#000000"
        "-baker-vertical-bounce": true
        "-baker-media-autoplay": true
        "-baker-background-image-portrait": "gfx/background-portrait.png"
        "-baker-background-image-landscape": "gfx/background-landscape.png"
        "-baker-page-numbers-color": "#000000"
        contents: contents

      # CHAPTERS
      Page.find(magazine: magazine._id).exec (err, pages) ->
        _.each pages, (page) ->
          return unless page.layout
          template = fs.readFileSync("./components/magazine/pages/" + (page.layout).trim() + ".html", "utf8")
          Article.findOne(_id: page.article).exec (err, article) ->
            if err then return
            File.find(relation: "article:" + article._id).execFind (err, files) ->
              articlefiles = {}
              _.each files, (file) ->
                fs.copySync process.cwd() + "/public/files/" + file.name, process.cwd() + "/public/books/" + magazine.title + "/hpub/images/" + file.name
                articlefiles[file.key] = file.name

              filename = "Page" + page.number + ".html"
              fs.writeFileSync "./public/books/" + magazine.title + "/hpub/" + filename, ejs.render template,
                magazine: magazine
                page: page
                article: article
                files: articlefiles

              PrintGenerator.generatePage filename, magazine if print
