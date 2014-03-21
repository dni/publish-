var express = require('express');
var _ = require('underscore');
var db = require(process.cwd() + '/components/backend/modules/article/model/ArticleSchema');
var db2 = require(process.cwd() + '/components/backend/modules/files/model/FileSchema');
var async = require('async');

module.exports.setup = function(app) {

	app.configure(function() {
		app.use('/lib', express.static(__dirname + '/bower_components'));
	});

	// web app
	app.get('/', function(req, res){
	  app.use('/', express.static(__dirname));
	  res.sendfile(__dirname+'/index.html');
	});


	// public Route
	app.get('/publicarticles', function(req,res) {
		db.Article.find({ 'privatecode': false }).execFind(function (arr,data) {
			var calls = [];

			data.forEach(function(article){

				article.files = [];

			    calls.push(function(callback) {

					db2.File.find({ 'relation': 'article:'+article._id}).execFind(function (arr,data) {
						data.forEach(function(file){
							article.files.push(file)
						});

			            callback(null, article);
					});
			    });
			});

			async.parallel(calls, function(err, result) {
				res.send(result);
			});


		});
	});


};


