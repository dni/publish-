var db = require(__dirname + '/model/ArticleSchema');

module.exports.setup = function(app) {
	
	// public Route
	app.get('/publicArticles', function(req,res) {
		db.Article.find({ 'privatecode': false }).limit(20).execFind(function (arr,data) {
	    	res.send(data);
		});
	});
	
	// API
	app.get('/articles', function(req, res){
	  	db.Article.find().limit(20).execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});
	
	app.post('/articles', function(req, res){
		var a = new db.Article();
		a.title = req.body.title;
		a.desc = req.body.desc;
		a.author = req.body.author;
		a.images = req.body.images;
		a.privatecode = req.body.privatecode;
		a.date = new Date();
	
		// upload progress
		// req.form.on('progress', function(bytesReceived, bytesExpected) {
	        // console.log(((bytesReceived / bytesExpected)*100) + "% uploaded");
	    // });
	    // req.form.on('end', function() {
	//     	
	    	// //upload done
	        // console.log(req.files);
	        // res.send("well done");
	    // });
		
		a.save(function () {
			res.send(a);
		});
		
	});
	
	app.put('/articles/:id', function(req, res){
		db.Article.findById( req.params.id, function(e, a) {
			a.title = req.body.title;
			a.desc = req.body.desc;
			a.author = req.body.author;
			a.images = req.body.images;
			a.privatecode = req.body.privatecode;
			a.date = new Date();
			a.save(function () {
				res.send(a);
			});
	  	});
	});
	
	app.delete('/articles/:id', function(req, res){
	  	db.Article.findById( req.params.id, function(e, a) {
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





