var db = require(__dirname + '/model/MagazineSchema'),
	PrintGenerator = require(__dirname + '/generators/PrintGenerator'), 
	Generator = require(__dirname + '/generators/index');

module.exports.setup = function(app) {
	// generator
	app.post("/generate", Generator.initialize);
	app.post("/generatePrint", PrintGenerator.generate);
	app.post("/downloadPrint", PrintGenerator.download);

	// public Route
	app.get('/publicMagazines', function(req,res) {
		db.Magazine.find({ 'privatecode': false }).limit(20).execFind(function (arr,data) {
	    	res.send(data);
		});
	});
	
	// download baker project
	app.get('/downloadApp', function(req, res){
		
		
		var spawn = require('child_process').spawn;
        // Options -r recursive -j ignore directory info - redirect to stdout
        var zip = spawn('zip', ['-r', '-', 'baker-master'], {cwd:__dirname});

        res.contentType('zip');

        // Keep writing stdout to res
        zip.stdout.on('data', function (data) {
            res.write(data);
        });

        zip.stderr.on('data', function (data) {
            // Uncomment to see the files being added
            console.log('zip stderr: ' + data);
        });

        // End the response on zip exit
        zip.on('exit', function (code) {
            if(code !== 0) {
                res.statusCode = 500;
                console.log('zip process exited with code ' + code);
                res.end();
            } else {
            	console.log("zip done");
                res.end();
            }
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

		// upload progress
		// req.form.on('progress', function(bytesReceived, bytesExpected) {
	        // console.log(((bytesReceived / bytesExpected)*100) + "% uploaded");
	    // });
	    // req.form.on('end', function() {
	//
	    	// //upload done
	        // console.log(req.files);
	        // res.send("well done");
	    // });
	    
	    
	    
	    // create folderstructure for hpub
		fs.mkdir("./public/magazines/" + req.body.title, function() {
			fs.mkdir("./public/magazines/" + req.body.title + "/hpub", function() {
				fs.mkdir("./public/magazines/" + req.body.title + "/hpub/images");
				fs.copy(__dirname + '/generators/hpub_dummy/css', './public/magazines/' + req.body.title + '/hpub/css');
				fs.copy(__dirname + "/generators/hpub_dummy/js", "./public/magazines/" + req.body.title + "/hpub/js");
			});
			fs.mkdir("./public/magazines/" + req.body.title + "/pdf", function() {});
		});
		
		
		a.save(function () {
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





