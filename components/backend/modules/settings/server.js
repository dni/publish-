var Setting = require(__dirname + '/model/SettingSchema'),
	mongoose = require("mongoose");


module.exports.setup = function(app) {

	app.get('/clearCache', function(req, res){
	  	Setting.collection.drop();
	  	var build = require(process.cwd()+'/components/backend/build.js');
	  	res.send("cache cleared");
	});


	app.get('/reset', function(req, res){
	  	Setting.collection.drop();
	  	res.send("module config reset");
	});

	// API
	app.get('/settings', function(req, res){
	  	Setting.find().execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});

	app.post('/settings', function(req, res){
		var s = new Setting();

		s.name = req.body.name;
		s.settings = req.body.settings;

		s.save(function () {
			res.send(s);
		});

	});

	app.put('/settings/:id', function(req, res){
		Setting.findById( req.params.id, function(e, s) {
			s.name = req.body.name;
			s.settings = req.body.settings;

			if (req.body.development && req.body.development.value) {
				var build = require('./components/backend/utilities/build.js');
			}

			s.save(function () {
				res.send(s);
			});

	  	});
	});

	app.delete('/settings/:id', function(req, res){
	  	db.Setting.findById( req.params.id, function(e, a) {
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





