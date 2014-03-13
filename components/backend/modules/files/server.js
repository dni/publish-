var db = require(__dirname + '/model/FileSchema');

module.exports.setup = function(app) {

	app.post("/uploadFile", function(req,res){
		console.log(req.files, req.body)
	});

	//## API
	app.get('/files', function(req, res) {
		db.File.find().limit(20).execFind(function(arr, data) {
			res.send(data);
		});
	});

	app.delete('/files/:id', function(req, res) {
		db.File.findById(req.params.id, function(e, a) {
			return a.remove(function(err) {
				if (!err) {
					return res.send('');
				} else {
					console.log(err);
				}
			});
		});
	});

};

