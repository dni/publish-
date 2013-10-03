var express = require('express'),
	app = express(),
	mongoose = require("mongoose"),
	// passport = require('passport'),
	// LocalStrategy = require('passport-local').Strategy,
	models = require('./server/models'), 
	routes = require('./server/routes'),
	ejs = require('ejs'),
	phantom = require("phantom")
	PrintGenerator = require("./server/generators/PrintGenerator");
	
 
phantom.create(PrintGenerator.startPhantom);
  
app.configure(function() {	
	app.use(express.static('public'));
	app.use('/static', express.static(__dirname + '/public'));  
	app.use('/lib', express.static('lib'));
	app.use(express.cookieParser());
	app.use(express.bodyParser());
	app.use(express.session({ secret: 'keyboard cat' }));
	
	// app.engine('.html', require('uinexpress').__express)
    // app.set('view engine', 'html')
	// app.use(passport.initialize());
	// app.use(passport.session());
	routes.setup(app);
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



// web app
app.get('/', function(req, res){	
  app.use('/frontend', express.static('frontend'));
  res.sendfile('./frontend/index.html');
});

app.get('/admin', function(req, res){
  app.use(express.basicAuth('admin', 'password'));
  app.use('/admin', express.static('admin'));
  res.sendfile('./admin/index.html'); 
});

// app.post('/login', passport.authenticate('local', { successRedirect: '/', failureRedirect: '/login' }));

app.listen(666);

// 
// function ensureAuthenticate(user, password){
	// return true;
	// var user = User.findByUsername(user);
	// return user ? user.password == password
// }

