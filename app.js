var express = require('express.io'),
	app = express(),
	passport = require("passport"),
	LocalStrategy = require('passport-local').Strategy,
	port = 1666,
	mongoose = require("mongoose"),
	User = require(__dirname +"/components/backend/modules/user/model/UserSchema.js")
	db = mongoose.connect('mongodb://localhost/publish'),
	fs = require('fs');

app.http().io()

app.configure(function() {

	// authentication
	passport.use(new LocalStrategy(function(username, password, done) {
	    User.findOne({ name: username, password: password }).execFind(function (err, user) {
	    	done(err, user[0]);
	    });
	}));

	passport.serializeUser(function(user, done) {
	  done(null, user._id);
	});

	passport.deserializeUser(function(_id, done) {
	  User.findById(_id, function (err, user) {
	  	if (!err) {
		  	app.user = {
		  		id: user._id,
		  		role: user.role
	  		}
	  	}
	    done(err, user);
	  });
	});

	app.use('/public', express.static(__dirname + '/public'));
	app.use('/bower_components', express.static(__dirname + '/bower_components'));

	app.use(express.bodyParser());
	app.use(express.cookieParser());
	app.use(express.session({ secret: 'publish crossplattform app' }));

	app.use(passport.initialize());
	app.use(passport.session());



	// load/setup components
	var componentsDir = __dirname + '/components/';
	fs.readdir(componentsDir, function (err, files) {
	  if (err) throw err;
	   files.forEach( function (file) {
	     fs.lstat(componentsDir+file, function(err, stats) {
	       if (!err && stats.isDirectory()) {
	         fs.exists(componentsDir+file+'/server.js', function(exists) {
			    if (exists) {
			        var component = require(componentsDir+file+'/server.js');
			        component.setup(app);
			    }
			});
	       }
	     });
	   });
	});

});

app.listen(port);



