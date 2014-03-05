var fs = require('fs'),
	_ = require('underscore'),
	ejs = require('ejs'),
	db = require('./../models');

module.exports.generate = function(res, magazine) {
	
	//  generate Cover
	fs.readFile('./server/generators/hpub_dummy/Book Cover.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine[0] });
		
		fs.writeFile("./public/magazines/" + magazine[0].title + "/hpub/Book Cover.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Cover was saved!");
			}
		});	
	});
	
	//  generate Back
	fs.readFile('./server/generators/hpub_dummy/Book Back.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine[0] });
		
		fs.writeFile("./public/magazines/" + magazine[0].title + "/hpub/Book Back.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Cover was saved!");
			}
		});	
	});
	
	//  generate Impressum
	fs.readFile('./server/generators/hpub_dummy/Tail.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine[0] });
		
		fs.writeFile("./public/magazines/" + magazine[0].title + "/hpub/Tail.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Tail was saved!");
			}
		});	
	});
	
	// generate Editorial
	fs.readFile('./server/generators/hpub_dummy/Book Index.html', 'utf8', function(err, template){
		if (err) throw err;

		var html = ejs.render(template, { magazine: magazine[0] });
		
		fs.writeFile("./public/magazines/" + magazine[0].title + "/hpub/Book Index.html", html, function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log("Index was saved!");
			}
		});	
	});
	
	// TODO: generate JSON
	// TODO: generate index
	
	// generate Chapters
	fs.readFile('./server/generators/hpub_dummy/Page.html', 'utf8', function(err, template){
		if (err) throw err;
		var pages = magazine[0].pages;

		var writePages = function(page) {
			if (page === undefined) page = pages.pop();
			db.Article.findOne({_id: page.article}).execFind(function(err, article){
				
				if (err) console.log(err);
				
				if (!article) article = [{
					title: "KAPUTT!",
					images: "KAPUUTT!",
					desc: "KAPUTT",
					author: "kaputt"
				}];
				
				var html = ejs.render(template, { magazine: magazine[0], page: page, article: article[0] });
				
				fs.writeFile("./public/magazines/" + magazine[0].title + "/hpub/Page" + page.number + ".html", html, function(err) {
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
			
			// generate Index
			
			
			return;
		};
		writePages();

	});
};
