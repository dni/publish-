var db = require(__dirname + '/model/FileSchema')
, fs = require("fs")
;

module.exports.setup = function(app) {

	app.post("/uploadFile", function(req,res){

		srcFiles = []

		if (req.files.files[0][0]===undefined){
			srcFiles[0] = req.files.files[0]
		} else {
			srcFiles = req.files.files[0]
		}

		len = srcFiles.length
		while(len--){
			var srcFile = srcFiles[len]
			var fileModel = new db.File();
			var targetLink = './public/files/'+srcFile.name;

			if (fs.existsSync(targetLink)===true){
				targetLink = './public/files/copy_'+Date.now()+'_'+srcFile.name;
			}

			fileModel.name = srcFile.name;
			fileModel.type = srcFile.type;
			fileModel.link = targetLink;

			fs.renameSync(srcFile.path, targetLink);
			fileModel.save(function () {
				res.send(fileModel);
			});

		}
		// this is only for lazyness
		// got no idea to stop redirect ...
		res.redirect('back');
	});

	//## API
	app.get('/files', function(req, res) {
		db.File.find().limit(20).execFind(function(arr, data) {
			console.log("data", data)
			res.send(data);
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

