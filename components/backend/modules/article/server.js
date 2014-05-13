var Article = require(__dirname + '/model/ArticleSchema');

module.exports.setup = function(app) {


	// API
	app.get('/articles', function(req, res){
	  	Article.find().limit(20).execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});

	app.post('/articles', function(req, res){
		var a = new Article();
		a.user = app.user.id;
		a.title = req.body.title;
		a.desc = req.body.desc;
		a.author = req.body.author;
		a.images = req.body.images;
		a.privatecode = req.body.privatecode;
		a.category = req.body.category;
		a.tags = req.body.tags;
		a.date = new Date();


		a.save(function () {
			req.io.broadcast('updateCollection', 'Articles');
			res.send(a);
		});

	});

	app.put('/articles/:id', function(req, res){
		Article.findById( req.params.id, function(e, a) {

			a.title = req.body.title;
			a.desc = req.body.desc;
			a.author = req.body.author;
			a.images = req.body.images;
			a.privatecode = req.body.privatecode;
			a.category = req.body.category;
			a.tags = req.body.tags;
			a.date = new Date();
			a.save(function () {
				req.io.broadcast('updateCollection', 'Articles');
				res.send(a);
			});
	  	});
	});

	app.delete('/articles/:id', function(req, res){
	  	Article.findById( req.params.id, function(e, a) {
			return a.remove(function (err) {
		      if (!err) {
		      	req.io.broadcast('updateCollection', 'Articles');
		        return res.send('');
		      } else {
		        console.log(err);
		      }
		    });
	  	});
	});

};





