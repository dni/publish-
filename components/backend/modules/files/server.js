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
			var name = srcFile.name;
			var targetLink = './public/files/' + name;


			if (fs.existsSync(targetLink)===true) {
				name = 'copy_'+Date.now()+'_'+srcFile.name;
				targetLink = './public/files/' + name;
			}

			fileModel.name = name;
			fileModel.type = srcFile.type;
			fileModel.link = './static/files/' + name;

			fs.renameSync(srcFile.path, targetLink);
			fileModel.save();

		}
		res.send('success');
	});

	//## API
	app.get('/files', function(req, res) {
		db.File.find().limit(20).execFind(function(arr, data) {
			res.send(data);
		});
	});

	app.put('/files/:id', function(req, res){
		db.File.findById(req.params.id, function(e, a) {
			if(a.name!=req.body.name) {
				link = './public/files/' + a.name;
				targetLink = './public/files/' + req.body.name;
				fs.renameSync(link, targetLink);
				a.link = './static/files/' + req.body.name;

			}
				a.name = req.body.name
				a.info = req.body.info
				a.alt = req.body.alt
				a.desc = req.body.desc

			a.save(function () { res.send(a); });
	  	});
	});

	app.delete('/files/:id', function(req, res) {
		db.File.findById(req.params.id, function(e, a) {

			if (fs.existsSync("./public/files/" + a.name)===true){
				fs.unlinkSync("./public/files/" + a.name);
			}

			return a.remove(function(err, model) {

				if (err) return console.log(err);

				return res.send('');
			});
		});
	});

};

