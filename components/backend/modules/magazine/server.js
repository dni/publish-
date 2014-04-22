var db = require(__dirname + '/model/MagazineSchema'),
	Page = require(__dirname + '/model/PageSchema'),
	fs = require('fs-extra'),
	PrintGenerator = require(__dirname + '/generators/PrintGenerator'),
	HpubGenerator = require(__dirname + '/generators/HpubGenerator');

module.exports.setup = function(app) {

	// generator
	app.get("/downloadPrint/:title", PrintGenerator.download);

	// API
	app.get('/magazines', function(req, res){
	  	db.Magazine.find().limit(20).execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});

	// create new magazine route
	app.post('/magazines', function(req, res){
		var a = new db.Magazine();
		a.title = req.body.title;
		a.editorial = req.body.editorial;
		a.impressum = req.body.impressum;
		a.author = req.body.author;
		a.pages = req.body.pages;
		a.papersize = req.body.papersize;
		a.orientation = req.body.orientation;
		a.date = new Date();

		a.save(function () {
			createMagazineFiles(req.body.title, function(){
				HpubGenerator.generate(a);
			});
			res.send(a);
		});

	});

	// update magazine route
	app.put('/magazines/:id', function(req, res){
		db.Magazine.findById( req.params.id, function(e, a) {

			// rerender Magazine Files
			var child_process = require('child_process').spawn;
		    var spawn = child_process('rm', ['-r', a.title], {cwd:'./public/books/'});
		    spawn.on('exit', function (code) {
		        if(code !== 0) {
					res.send(a);
		            console.log('remove Magazine '+ a.title +' exited with code ' + code);
		        } else {
		        	console.log("removed Magazine Files: " + req.body.title);

					a.editorial = req.body.editorial;
					a.impressum = req.body.impressum;
					a.cover = req.body.cover;
					a.back = req.body.back;
					a.author = req.body.author;
					a.pages = req.body.pages;
					a.published = req.body.published;
					a.papersize = req.body.papersize;
					a.orientation = req.body.orientation;
					a.files = req.body.files;
					a.date = new Date();
					a.title = req.body.title;

		        	a.save(function () {
		        		console.log("created Magazine Files: " + a.title);
						createMagazineFiles(req.body.title, function(){ HpubGenerator.generate(a); });
						res.send(a);
					});
		        }
		    });

	  	});
	});

	app.delete('/magazines/:id', function(req, res){
	  	db.Magazine.findById( req.params.id, function(e, a) {
			return a.remove(function (err) {
		      if (!err) {
		      	var child_process = require('child_process').spawn;
				var spawn = child_process('rm', ['-rf', '-', a.title], {cwd:process.cwd()+'/public/books/'});
			    spawn.on('exit', function (code) {
			        if(code !== 0) {
			            res.statusCode = 500;
			            console.log('remove book/yourmagazine (rm) process exited with code ' + code);
			        } else {return res.send('deleted');}
				});
		      } else {
		        console.log(err);
		      }
		    });
	  	});
	});


	// API Pages
	app.get('/pages', function(req, res){
		if (!req.query.magazine) res.send("no magazine id");
	  	Page.find({magazine: req.query.magazine}).execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});

	app.post('/pages', function(req, res){
		var a = new Page();
		a.magazine = req.body.magazine;
		a.article = req.body.article;
		a.number = req.body.number;
		a.layout = req.body.layout;
		a.save(function () {
			res.send(a);
		});
	});

	app.put('/pages/:id', function(req, res){
		Page.findById( req.params.id, function(e, a) {
			a.magazine = req.body.magazine;
			a.article = req.body.article;
			a.number = req.body.number;
			a.layout = req.body.layout;
			a.save(function () {
				res.send(a);
			});

	  	});
	});

	app.delete('/pages/:id', function(req, res){
	  	Page.findById( req.params.id, function(e, model) {
			return model.remove(function (err) {
		      if (!err) {
		        return res.send('');
		      } else {
		        console.log(err);
		      }
		    });
	  	});
	});


};


// Setup
function createMagazineFiles(folder, cb) {
	fs.mkdirSync('./public/books/' + folder);
	fs.copySync('./components/magazine/gfx', './public/books/' + folder + '/hpub/gfx');
	fs.copySync('./components/magazine/css', './public/books/' + folder + '/hpub/css');
	fs.copySync('./components/magazine/js', "./public/books/" + folder + "/hpub/js");
	fs.copySync('./components/magazine/images', './public/books/' + folder + '/hpub/images');
	cb();
};






