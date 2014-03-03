var express = require('express');

module.exports.setup = function(app) {
	
	app.configure(function() {
		app.use('/lib', express.static(__dirname + '/bower_components'));
	});
	
	// web app
	app.get('/', function(req, res){
	  app.use('/', express.static(__dirname));
	  res.sendfile(__dirname+'/index.html');
	});
};


