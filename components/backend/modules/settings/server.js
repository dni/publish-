var db = require(__dirname + '/model/SettingSchema'),
	mongoose = require("mongoose");

module.exports.setup = function(app) {
	
	app.get('/clearCache', function(req, res){
	  	db.Setting.collection.drop();
	  	res.send("cache cleared");
	});
	
	app.get('/reset', function(req, res){
	  	db.Setting.collection.drop();
	  	res.send("module config reset");
	});
	
	// API
	app.get('/settings', function(req, res){
	  	db.Setting.find().execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});
	
	app.post('/settings', function(req, res){
		var s = new db.Setting();
		s.name = req.body.name;
		s.settings = req.body.settings;

		s.save(function () {
			res.send(s);
		});
		
	});
	
	app.put('/settings/:id', function(req, res){
		db.Setting.findById( req.params.id, function(e, s) {
			s.name = req.body.name;
			s.settings = req.body.settings;
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





