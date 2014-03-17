var fs = require('fs');
var scissors = require('scissors');
var path = require('path');
var mime = require('mime');
var phantom = require("phantom");
var port = 40000;

module.exports.download = function(req, res){
	var pages = [];
	fs.unlink("./public/books/" + req.params.title + "/pdf/Print.pdf", function(){
		fs.readdir("./public/books/" + req.params.title + "/pdf/", function(err, files) {
			if (err) return;
			for (var key = 0; key < files.length; key++) {
				if (files[key].match(/.pdf/g)) {
					pages.push(scissors("./public/books/" + req.params.title + "/pdf/" + files[key]));
				}
			}
			var stream = fs.createWriteStream("./public/books/" + req.params.title + "/pdf/Print.pdf");
			var pdfStream = scissors.join.apply(null, pages).pdfStream();
			pdfStream.pipe(stream);
			pdfStream.on("end", function(){
				res.download("./public/books/" + req.params.title + "/pdf/Print.pdf");
			});
		});
	});
};

module.exports.generatePage = function(file, magazine) {
	phantom.create({port: port++}, function(ph){
		ph.createPage(function(page) {
			return page.open("./public/books/" + magazine.title + "/hpub/" + file, function(status) {
				if (status !== "success") {
					console.log("unable to open page");
					ph.exit();
				}
				return page.evaluate(function() {
					return document;
				}, function(result) {
					var split = file.split(".");
					page.set('paperSize', {
						format : "A5",
						orientation : 'portrait',
						margin : '0'
					});
					// page.paperSize = { format: "A5", orientation: 'portrait', margin: '1cm' };
					page.render("./public/books/" + magazine.title + "/pdf/" + split.shift() + ".pdf");
				});
			});
		});
	});
};


module.exports.generate = function(magazine) {
	fs.readdir("./public/books/" + magazine.title + "/hpub/", function(err, files) {
		if (err) return;
		var port = 40000;
		var renderPages = function(file) {
			phantom.create({port: port++}, function(ph){
				ph.createPage(function(page) {
					return page.open("./public/books/" + magazine.title + "/hpub/" + file, function(status) {
						if (status !== "success") {
							console.log("unable to open page");
							ph.exit();
						}
						return page.evaluate(function() {
							return document;
						}, function(result) {
							var split = file.split(".");
							page.set('paperSize', {
								format : "A5",
								orientation : 'portrait',
								margin : '0'
							});
							// page.paperSize = { format: "A5", orientation: 'portrait', margin: '1cm' };
							page.render("./public/books/" + magazine.title + "/pdf/" + split.shift() + ".pdf");
						});
					});
				});
			});

		};
		for (key in files) {
			if (files[key].match(/.html/g)) {
				renderPages(files[key]);
			}
		}
	});
};
