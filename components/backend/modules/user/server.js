var User = require(__dirname + '/model/UserSchema'),
	express = require('express'),
	auth = require(__dirname + "/auth.js"),
	passport = require('passport');

module.exports.setup = function(app) {
	User.count({},function(err, count) {
		if (count == 0) {
			var admin = new User();
			admin.name = "admin";
			admin.password = "password";
			admin.role = 0;
			admin.save();
			console.log("admin user was created");
		}
	});

	app.get('/login', function(req, res){
	  res.sendfile(process.cwd()+'/components/backend/modules/user/templates/login.html');
	});

	app.post('/login', passport.authenticate('local', { failureRedirect: '/login' }), function(req, res) {
	    res.redirect('/admin');
	});

	app.get('/logout', function(req, res){
	  req.logout();
	  res.redirect('/login');
	});

	app.get('/admin', auth, function(req, res){
	  // production mode!
	  // app.use('/admin', express.static(process.cwd()+'/cache/build'));
	  // res.sendfile(process.cwd()+'/cache/build/index.html');

	  app.use('/admin', express.static(process.cwd()+'/components/backend'));
	  // workaround for requirejs i18n problem with /admin
	  app.use('/modules', express.static(process.cwd()+'/components/backend/modules'));
	  res.sendfile(process.cwd()+'/components/backend/index.html');
	});

	app.get('/user', auth, function(req, res){
	  res.send(app.user);
	});

	// API
	app.get('/users', auth, function(req, res){
	  	User.find().limit(20).execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});

	app.post('/users', auth, function(req, res){
		var a = new User();
		a.name = req.body.name;
		a.role = req.body.role;
		a.password = req.body.password;

		a.save(function () {
			res.send(a);
		});

	});

	app.put('/users/:id', auth, function(req, res){
		User.findById( req.params.id, function(e, a) {

			a.name = req.body.name;
			a.role = req.body.role;
			a.password = req.body.password;

			a.save(function () {
				res.send(a);
			});
	  	});
	});

	app.delete('/users/:id', auth, function(req, res){
	  	User.findById( req.params.id, function(e, a) {
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





