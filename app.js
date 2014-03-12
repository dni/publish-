var express = require('express'),
	app = express(),
	mongoose = require("mongoose"),
	db = mongoose.connect('mongodb://localhost/publish'),
	fs = require('fs');


app.configure(function() {

	app.use(express.static('public'));
	app.use('/static', express.static(__dirname + '/public'));
	app.use(express.cookieParser());


	app.use(express.session({ secret: 'keyboard cat' }));

	// app.engine('.html', require('uinexpress').__express)
    // app.set('view engine', 'html')
	// app.use(passport.initialize());
	// app.use(passport.session());

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


// passport.use(new LocalStrategy(
  // function(username, password, done) {
   // models.User.findOne({ username: username }, function(err, user) {
      // if (err) { return done(err); }
      // if (!user) {
        // return done(null, false, { message: 'Incorrect username.' });
      // }
      // if (!user.validPassword(password)) {
        // return done(null, false, { message: 'Incorrect password.' });
      // }
      // return done(null, user);
    // });
  // }
// ));

// app.post('/login', passport.authenticate('local', { successRedirect: '/', failureRedirect: '/login' }));

app.listen(1666);

