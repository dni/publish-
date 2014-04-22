var fs = require('fs-extra'),
	_ = require('underscore'),
	ejs = require('ejs'),
	PrintGenerator = require(__dirname + '/PrintGenerator'),
	db = require('./../model/MagazineSchema'),
	db2 = require('./../../article/model/ArticleSchema');
	dbFile = require('./../../files/model/FileSchema');
	Settings = require('./../../settings/model/SettingSchema');
	Page = require('./../model/PageSchema');

module.exports.generate = function(magazine) {

	dbFile.File.find({relation: 'magazine:'+magazine._id}).execFind(function(err, files){

		magazinefiles = {};

		_.each(files, function(file){
			fs.copy(process.cwd() + '/public/files/'+file.name, process.cwd()+"/public/books/" + magazine.title + "/hpub/images/" + file.name );
			magazinefiles[file.key] = file.name;
		});

		// generage INDEX
		Page.find({magazine: magazine._id}).exec(function(err, pages){
			var articleIds = [];
			_.each(pages, function(page){
				articleIds.push(page.article);
			});


			db2.Article.find({_id: { $in: articleIds}}).execFind(function(err, articles){
				var newarticles = {};
				_.each(articles, function(article){
					newarticles[article._id] = article.title;
				});

				var template = fs.readFileSync('./components/magazine/index.html', 'utf8');

				var html = ejs.render(template, {
					magazine: magazine,
					pages: pages,
					articles:newarticles
				});

				fs.writeFileSync("./public/books/" + magazine.title + "/hpub/index.html", html);

				Settings.findOne({name: 'Magazines'}).execFind(function(err, file){
					file = file.pop();
					if (file.settings.print.value) {
						PrintGenerator.generatePage("index.html", magazine);
					}
				});
			});
		});


		// generate Cover
		var template = fs.readFileSync('./components/magazine/Book Cover.html', 'utf8');
		fs.writeFileSync("./public/books/" + magazine.title + "/hpub/Book Cover.html", ejs.render(template, { magazine: magazine, cover: magazinefiles['cover'] }));

		//  generate Back
		template = fs.readFileSync('./components/magazine/Book Back.html', 'utf8');
		fs.writeFileSync("./public/books/" + magazine.title + "/hpub/Book Back.html", ejs.render(template, { magazine: magazine, back: magazinefiles['back'] }));

		// generate Impressum
		template = fs.readFileSync('./components/magazine/Tail.html', 'utf8');
		fs.writeFileSync("./public/books/" + magazine.title + "/hpub/Tail.html", ejs.render(template, { magazine: magazine }));

		// generate Editorial
		template = fs.readFileSync('./components/magazine/Book Index.html', 'utf8');
		fs.writeFileSync("./public/books/" + magazine.title + "/hpub/Book Index.html", ejs.render(template, { magazine: magazine}));


		// generate JSON
		var files = fs.readdirSync("./public/books/" + magazine.title + "/hpub/");

		var contents = [], key;
		for (key = 0; key < files.length; key++) {
			if (files[key].match(/.html/g)) {
				contents.push(files[key]);
			}
		}

		var json = {
		    "hpub": 1,
		    "title": magazine.title,
		    "author": [magazine.author],
		    "creator": [magazine.author],
		    "date": new Date(),
		    "url": "book://localhost:1666/public/books/"+magazine.title+"/hpub",

		    "orientation": "both",
		    "zoomable": false,

		    "-baker-background": "#000000",
		    "-baker-vertical-bounce": true,
		    "-baker-media-autoplay": true,
		    "-baker-background-image-portrait": "gfx/background-portrait.png",
		    "-baker-background-image-landscape": "gfx/background-landscape.png",
		    "-baker-page-numbers-color": "#000000",

		    "contents": contents
		};

		fs.writeFileSync("./public/books/" + magazine.title + "/hpub/book.json", JSON.stringify(json));

		// CHAPTERS
		Page.find({magazine: magazine._id}).exec(function(err, pages){

			_.each(pages, function(page){
				if (!page.layout) { return; }

				template = fs.readFileSync('./components/magazine/pages/'+(page.layout).trim()+'.html', 'utf8');
				db2.Article.findOne({_id: page.article}).execFind(function(err, article){

					// shouldnt happen again was bug in save page, without article value
					if (err) { return console.log(err, "no article found in pages !?"); }

					dbFile.File.find({ 'relation': 'article:'+article._id}).execFind(function(err, files){

						var articlefiles = {};

						_.each(files, function(file){
							fs.copySync(process.cwd() + '/public/files/'+file.name, process.cwd()+"/public/books/" + magazine.title + "/hpub/images/" + file.name );
							articlefiles[file.key] = file.name;
						});

						var html = ejs.render(template, {
							magazine: magazine,
							page: page,
							article: article,
							files: articlefiles
						});

						var filename = "Page" + page.number + ".html";
						fs.writeFileSync("./public/books/" + magazine.title + "/hpub/" + filename, html);

						Settings.findOne({name: 'Magazines'}).execFind(function(err, file){
							file = file.pop();
							if (file.settings.print.value) {
								PrintGenerator.generatePage(filename, magazine);
							}
						});
					});
				});
			});

		});

		Settings.findOne({name: 'Magazines'}).execFind(function(err, file){
			file = file.pop();
			if (file.settings.print.value) {
				PrintGenerator.generatePage("Book Cover.html", magazine);
				PrintGenerator.generatePage("Book Back.html", magazine);
				PrintGenerator.generatePage("Tail.html", magazine);
				PrintGenerator.generatePage("Book Index.html", magazine);
			}
		});
	});


};
