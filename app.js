var express = require('express'),
	app = express(),
	port = 1666,
	mongoose = require("mongoose"),
	db = mongoose.connect('mongodb://localhost/publish'),
	fs = require('fs');


app.configure(function() {

	app.use(express.static('public'));
	app.use('/static', express.static(__dirname + '/public'));
	app.use(express.cookieParser());

	// load/setup components
	var componentsDir = __dirname + '/components/';
	fs.readdir(componentsDir, function (err, files) {
	  if (err) throw err;
	   files.forEach( function (file) {
	     fs.lstat(componentsDir+file, function(err, stats) {
	       if (!err && stats.isDirectory()) {
	         fs.exists(componentsDir+file+'/server.js', function(exists) {
			    if (exists) {
			        var component = require(componentsDir+file+'/server.js');
			        component.setup(app);
			    }
			});
	       }
	     });
	   });
	});

});

app.listen(port);

