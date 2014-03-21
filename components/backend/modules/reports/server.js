var db = require(__dirname + '/model/Schema'),
	fs = require("fs");

module.exports.setup = function(app) {


	//## API
	app.get('/reports', function(req, res) {
		db.Report.find().limit(20).execFind(function(arr, data) {
			res.send(data);
		});
	});

	// make weekly report
	// app.post('/files', function(req, res) {
		// file = new db.File();
		// file.type = req.body.type;
		// file.save(function(){
			// res.send(file);
		// });
	// });



};

