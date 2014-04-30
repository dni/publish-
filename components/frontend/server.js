var express = require('express');
var _ = require('underscore');
var Article = require(process.cwd() + '/components/backend/modules/article/model/ArticleSchema');
var File = require(process.cwd() + '/components/backend/modules/files/model/FileSchema');
var Blocks = require(process.cwd() + '/components/backend/modules/static/model/StaticBlockSchema');
var async = require('async');

module.exports.setup = function(app) {

	app.use('/', express.static(__dirname));

	// web app
	app.get('/', function(req, res){
	  res.sendfile(__dirname+'/index.html');
	});

	app.get('/blocks', function(req,res) {
		Blocks.find({ 'key': { $in: req.query.blocks}}).execFind(function (arr,data) {
			res.send(data);
		});
	});


	// public Route
	app.get('/publicarticles', function(req,res) {
		Article.find({ 'privatecode': false }).execFind(function (arr,data) {
			var calls = [];

			data.forEach(function(article){

				article.files = [];

			    calls.push(function(callback) {

					File.find({ 'relation': 'article:'+article._id}).execFind(function (arr,data) {
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


