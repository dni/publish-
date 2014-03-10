var db = require('./../model/MagazineSchema');
var fs = require('fs-extra');
var hpubGenerator = require('./../generators/HpubGenerator');


module.exports.initialize = function(req, res) {
	console.log("into generator")
	if (fs.existsSync("./public/magazines/" + req.body.title)) {
		db.Magazine.findOne({_id: req.body.id}).execFind(function (arr,data) {
			hpubGenerator.generate( res, data );
	  	});
		res.send("hpub generated");
		return;
	};

	fs.mkdir("./public/magazines/" + req.body.title, function() {
		fs.mkdir("./public/magazines/" + req.body.title + "/hpub", function() {
			fs.mkdir("./public/magazines/" + req.body.title + "/hpub/images");
			fs.copy('./server/generators/hpub_dummy/css', './public/magazines/' + req.body.title + '/hpub/css');
			fs.copy("./server/generators/hpub_dummy/js", "./public/magazines/" + req.body.title + "/hpub/js");
		});
		fs.mkdir("./public/magazines/" + req.body.title + "/pdf", function() {});
	});

	db.Magazine.findOne({_id: req.body.id}).execFind(function (arr,data) {
		hpubGenerator.generate( res, data );
  	});

	res.send("initialize done");
};