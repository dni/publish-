var db = require(__dirname + '/model/MagazineSchema');

module.exports.setup = function(app) {

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
		a.desc = req.body.desc;
		a.author = req.body.author;
		a.images = req.body.images;
		a.privatecode = req.body.privatecode;
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

		a.save(function () {
			res.send(a);
		});

	});

	app.put('/magazines/:id', function(req, res){
		db.Magazine.findById( req.params.id, function(e, a) {
			a.title = req.body.title;
			a.desc = req.body.desc;
			a.author = req.body.author;
			a.images = req.body.images;
			a.privatecode = req.body.privatecode;
			a.date = new Date();
			a.save();
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





