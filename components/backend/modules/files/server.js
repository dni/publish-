var db = require(__dirname + '/model/FileSchema')
, connect = require("connect")
, multipart = require("connect-multiparty")

var middleware = multipart();
//Filemanager = require(__dirname + '/generators/PrintGenerator')

module.exports.setup = function(app) {

	filemanager = {
		load : function() {
			console.log("save file to server");
		},
		save : function() {
			console.log("load file from server");
		}
	}

	app.post("/loadFile", filemanager.load);
	app.post("/uploadFile", middleware, function(req,res){
		console.log(req.files, req.body)

	});

	//## API
	app.get('/files', function(req, res) {
		db.File.find().limit(20).execFind(function(arr, data) {
			res.send(data);
		});
	});

	app.put('/files/:id', function(req, res) {
		db.File.findById(req.params.id, function(e, a) {
			a.name = req.body.title;
			a.link = req.body.editorial;
			a.type = req.body.impressum;
			a.save(function() {
				res.send(a);
			});
		});
	});

	app["delete"]('/files/:id', function(req, res) {
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

