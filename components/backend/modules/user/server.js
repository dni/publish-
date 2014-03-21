var db = require(__dirname + '/model/UserSchema'),
	express = require('express');

module.exports.setup = function(app) {


	app.get('/admin', function(req, res){

	 // db.User.find({
	 	// username: req.body.username,
	 	// password: req.body.password
	 // });


	  app.use(express.basicAuth('admin', 'password'));
	  app.use('/admin', express.static(process.cwd()+'/components/backend'));
	  res.sendfile(process.cwd()+'/components/backend/index.html');


	});

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





