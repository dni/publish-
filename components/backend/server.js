var fs = require('fs'),
	express = require("express");


module.exports.setup = function(app) {

	app.configure(function() {
		app.use('/admin/lib', express.static(__dirname + '/bower_components'));
		app.use(express.bodyParser());
		// load/setup modules
		var moduleDir = __dirname + '/modules/';
		fs.readdir(moduleDir, function (err, files) {
		  if (err) throw err;
		   files.forEach( function (file) {
		     fs.lstat(moduleDir+file, function(err, stats) {
		       if (!err && stats.isDirectory()) {
		         fs.exists(moduleDir+file+'/server.js', function(exists) {
				    if (exists) {
				        var module = require(moduleDir+file+'/server.js');
				        module.setup(app);
				    }
				});
		       }
		     });
		   });
		});
	});


};
