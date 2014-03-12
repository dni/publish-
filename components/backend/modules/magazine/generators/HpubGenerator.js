var fs = require('fs'),
	_ = require('underscore'),
	ejs = require('ejs'),
	PrintGenerator = require(__dirname + '/PrintGenerator'), 
	db = require('./../model/MagazineSchema'),
	db2 = require('./../../article/model/ArticleSchema');


module.exports.generate = function(magazine) {

	// generate Cover
	fs.readFile(__dirname + '/hpub_dummy/Book Cover.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine });

		fs.writeFile(__dirname + "/public/magazines/" + magazine.title + "/hpub/Book Cover.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Cover was saved!");
			}
		});
	});

	//  generate Back
	fs.readFile(__dirname + '/hpub_dummy/Book Back.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine });

		fs.writeFile("./public/magazines/" + magazine.title + "/hpub/Book Back.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Cover was saved!");
			}
		});
	});

	//  generate Impressum
	fs.readFile(__dirname + '/hpub_dummy/Tail.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine });

		fs.writeFile("./public/magazines/" + magazine.title + "/hpub/Tail.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Tail was saved!");
			}
		});
	});

	// generate Editorial
	fs.readFile(__dirname + '/hpub_dummy/Book Index.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine });

		fs.writeFile("./public/magazines/" + magazine.title + "/hpub/Book Index.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Index was saved!");
			}
		});
	});

	// generate JSON	
	fs.readdir("./public/magazines/" + magazine.title + "/hpub/", function(err, files) {
		if (err) return;
		var contents = [];
		for (var key = 0; key < files.length; key++) {
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
		    "url": "book://localhost:1666/public/magazines/"+magazine.title+"/hpub",
		
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
		
		fs.writeFile("./public/magazines/" + magazine.title + "/hpub/book.json", JSON.stringify(json), function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Index was saved!");
			}
		});
	});
	
	
	
	//  generate index
	fs.readFile(__dirname + '/hpub_dummy/index.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine });

		fs.writeFile("./public/magazines/" + magazine.title + "/hpub/index.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Cover was saved!");
			}
		});
	});
	

	// generate Chapters
	fs.readFile(__dirname + '/hpub_dummy/Page.html', 'utf8', function(err, template){
		if (err) throw err;
		var pages = magazine.pages;

		var writePages = function(page) {
			if (page === undefined) page = pages.pop();
			db2.Article.findOne({_id: page.article}).execFind(function(err, article){

				if (err) console.log(err);

				if (!article) article = [{
					title: "KAPUTT!",
					images: "KAPUUTT!",
					desc: "KAPUTT",
					author: "naturtrüb"
				}];

				var html = ejs.render(template, { magazine: magazine, page: page, article: article[0] });

				fs.writeFile("./public/magazines/" + magazine.title + "/hpub/Page" + page.number + ".html", html, function(err) {
					if (err) {
						console.log(err);
					} else {
						console.log("The file was saved!");
					}
				});
			});

			var nextPage = pages.pop();
			if (nextPage) {
				writePages(nextPage);
			}
			return;
		};
		
		writePages();

	});
	
	PrintGenerator.generate(magazine);
};
