var db = require(__dirname + '/model/Schema'),
	fs = require("fs");

module.exports.setup = function(app) {


	//## API
	app.get('/messages', function(req, res) {
		db.Message.find().limit(20).execFind(function(arr, data) {
			res.send(data);
		});
	});

	// chat!!!
	// app.post('/messages', function(req, res) {
		// file = new db.File();
		// file.type = req.body.type;
		// file.save(function(){
			// res.send(file);
		// });
	// });



};

