var db = require('./../models'),
	fs = require('fs');

module.exports.publicArticles = function(req,res) {
	db.Article.find({ 'privatecode': false }).limit(20).execFind(function (arr,data) {
    	res.send(data);
	});
};

module.exports.getArticles = function(req, res){
  	db.Article.find().limit(20).execFind(function (arr,data) {
    	res.send(data);
  	});
};

module.exports.postArticles = function(req, res){
	
	var article = new db.Article();
	article.title = req.body.title;
	article.desc = req.body.desc;
	article.author = req.body.author;
	article.images = req.body.images;
	article.privatecode = req.body.privatecode;
	article.date = new Date();

	// upload progress
	// req.form.on('progress', function(bytesReceived, bytesExpected) {
        // console.log(((bytesReceived / bytesExpected)*100) + "% uploaded");
    // });
//     
//     
    // req.form.on('end', function() {
//     	
    	// //upload done
        // console.log(req.files);
        // res.send("well done");
//         
//         
//         
    // });
	
	article.save(function () {
		res.send(article);
	});

	
};

module.exports.updateArticle = function(req, res){
	db.Article.findById( req.params.id, function(e, a) {
		a.title = req.body.title;
		a.desc = req.body.desc;
		a.author = req.body.author;
		a.images = req.body.images;
		a.privatecode = req.body.privatecode;
		a.date = new Date();
		a.save();
  	});
};

module.exports.deleteArticle = function(req, res){
  	db.Article.findById( req.params.id, function(e, a) {
		a.remove();
  	});
};
