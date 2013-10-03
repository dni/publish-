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
	
	var data = req.body.images.split(".");
	
	var images = "";
	
	for (var key in data) {	

	  var base64Data = data[key].replace(/^data:image\/png;base64,/,"");
	  var newPath = "./public/articles/" + base64Data + ".png";
	  
	  fs.writeFile(newPath, base64Data, 'base64', function (err) {

	  });
	  images += "," + newPath;
	}
	
	links = images.substr(1,images.length);
	console.log(links);
	article.images = links;

	
	article.privatecode = req.body.privatecode;
	article.date = new Date();
	
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
