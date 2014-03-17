var fs = require('fs'),
	_ = require('underscore'),
	ejs = require('ejs'),
	PrintGenerator = require(__dirname + '/PrintGenerator'),
	db = require('./../model/MagazineSchema'),
	db2 = require('./../../article/model/ArticleSchema');


module.exports.generate = function(magazine) {

	// generate Cover
	var template = fs.readFileSync(__dirname + '/hpub_dummy/Book Cover.html', 'utf8');
	fs.writeFileSync("./public/books/" + magazine.title + "/hpub/Book Cover.html", ejs.render(template, { magazine: magazine }));
	PrintGenerator.generatePage("Book Cover.html", magazine);

	//  generate Back
	template = fs.readFileSync(__dirname + '/hpub_dummy/Book Back.html', 'utf8');
	fs.writeFileSync("./public/books/" + magazine.title + "/hpub/Book Back.html", ejs.render(template, { magazine: magazine }));
	PrintGenerator.generatePage("Book Back.html", magazine);

	//  generate index
	template = fs.readFileSync(__dirname + '/hpub_dummy/index.html', 'utf8');
	fs.writeFileSync("./public/books/" + magazine.title + "/hpub/index.html", ejs.render(template, { magazine: magazine }));
	PrintGenerator.generatePage("index.html", magazine);

	// generate Impressum
	template = fs.readFileSync(__dirname + '/hpub_dummy/Tail.html', 'utf8');
	fs.writeFileSync("./public/books/" + magazine.title + "/hpub/Tail.html", ejs.render(template, { magazine: magazine }));
	PrintGenerator.generatePage("Tail.html", magazine);

	// generate Editorial
	template = fs.readFileSync(__dirname + '/hpub_dummy/Book Index.html', 'utf8');
	fs.writeFileSync("./public/books/" + magazine.title + "/hpub/Book Index.html", ejs.render(template, { magazine: magazine }));
	PrintGenerator.generatePage("Book Index.html", magazine);

	// generate JSON
	var files = fs.readdirSync("./public/books/" + magazine.title + "/hpub/");

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
	template = fs.readFileSync(__dirname + '/hpub_dummy/Page.html', 'utf8');
	_.each(magazine.pages, function(page){
		db2.Article.findOne({_id: page.article}).execFind(function(err, article){
			if (err) console.log(err);
			if (!article) article = [{
				title: "KAPUTT!",
				images: "KAPUUTT!",
				desc: "KAPUTT",
				author: "naturtrüb"
			}];
			var html = ejs.render(template, { magazine: magazine, page: page, article: article });
			var file = "Page" + page.number + ".html";
			fs.writeFileSync("./public/books/" + magazine.title + "/hpub/" + file, html);
			PrintGenerator.generatePage(file, magazine);
		});
	});


};
