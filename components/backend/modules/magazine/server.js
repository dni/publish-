var db = require(__dirname + '/model/MagazineSchema'),
	fs = require('fs'),
	PrintGenerator = require(__dirname + '/generators/PrintGenerator'),
	BakerGenerator = require(__dirname + '/generators/BakerGenerator'),
	HpubGenerator = require(__dirname + '/generators/HpubGenerator');

module.exports.setup = function(app) {
	
	// generator
	app.post("/downloadPrint", PrintGenerator.download);
	app.get('/downloadApp', BakerGenerator.download);
	

	// public Route
	app.get('/publicMagazines', function(req,res) {
		db.Magazine.find({ 'privatecode': false }).limit(20).execFind(function (arr,data) {
	    	res.send(data);
		});
	});
	

	// API
	app.get('/magazines', function(req, res){
	  	db.Magazine.find().limit(20).execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});

	app.post('/magazines', function(req, res){
		
		 
		var a = new db.Magazine();
		a.title = req.body.title;
		a.editorial = req.body.editorial;
		a.impressum = req.body.impressum;
		a.cover = req.body.cover;
		a.back = req.body.back;
		a.pages = req.body.pages;
		a.date = new Date();
		
		a.save(function () {
			initialize(req.body.title, function(){
				HpubGenerator.generate(a);
			});
			res.send(a);
		});

	});

	app.put('/magazines/:id', function(req, res){
		db.Magazine.findById( req.params.id, function(e, a) {
			a.title = req.body.title;
			a.editorial = req.body.editorial;
			a.impressum = req.body.impressum;
			a.cover = req.body.cover;
			a.back = req.body.back;
			a.pages = req.body.pages;
			a.published = req.body.published;
			a.date = new Date();
			a.save(function () {
				res.send(a);
			});
	  	});
	});

	app.delete('/magazines/:id', function(req, res){
	  	db.Magazine.findById( req.params.id, function(e, a) {
			return a.remove(function (err) {
		      if (!err) {
		        return res.send('');
		      } else {
		        console.log(err);
		      }
		    });
	  	});
	});

};

function initialize(folder, cb) {
	fs.mkdir("./public/magazines/" + folder, function() {
		fs.mkdir("./public/magazines/" + folder + "/hpub", function() {
			fs.mkdir("./public/magazines/" + folder + "/hpub/images");
			fs.copy(__dirname + '/generators/hpub_dummy/css', './public/magazines/' + folder + '/hpub/css');
			fs.copy(__dirname + "/generators/hpub_dummy/js", "./public/magazines/" + folder + "/hpub/js");
		});
		fs.mkdir("./public/magazines/" + folder + "/pdf", function() {});
		cb();
	});
}





