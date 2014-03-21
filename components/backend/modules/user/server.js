var db = require(__dirname + '/model/UserSchema');

module.exports.setup = function(app) {


	// API
	app.get('/users', function(req, res){
	  	db.User.find().limit(20).execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});

	app.post('/users', function(req, res){
		var a = new db.User();
		a.name = req.body.name;
		a.role = req.body.role;
		a.password = req.body.password;

		a.save(function () {
			res.send(a);
		});

	});

	app.put('/users/:id', function(req, res){
		db.User.findById( req.params.id, function(e, a) {

			a.name = req.body.name;
			a.role = req.body.role;
			a.password = req.body.password;

			a.save(function () {
				res.send(a);
			});
	  	});
	});

	app.delete('/users/:id', function(req, res){
	  	db.User.findById( req.params.id, function(e, a) {
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





