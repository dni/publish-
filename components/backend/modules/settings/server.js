var Setting = require(__dirname + '/model/SettingSchema');

module.exports.setup = function(app) {

	app.get('/clearCache', function(req, res){
		var spawn = require('child_process').spawn;
	    var grunt = spawn('grunt', ['build']);
	    grunt.on("end",function(){
	    	res.send("cache cleared");
	    });
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
	  	Setting.findById( req.params.id, function(e, a) {
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





