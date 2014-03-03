var mongoose = require("mongoose"),
	express = require("express"),
	ejs = require('ejs'),
	phantom = require("phantom"),
	// PrintGenerator = require("./server/generators/PrintGenerator"),
	fs = require('fs');

module.exports.setup = function(app) {
	
	// phantom.create(PrintGenerator.startPhantom);
	app.configure(function() {
		app.use('/admin/lib', express.static(__dirname + '/bower_components'));
		
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

	app.get('/admin', function(req, res){
	  app.use(express.basicAuth('admin', 'password'));
	  app.use('/admin', express.static(__dirname));
	  res.sendfile(__dirname+'/index.html');
	});

};
