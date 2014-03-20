var db = require(__dirname + '/model/FileSchema'),
	fs = require("fs");

module.exports.setup = function(app) {

	app.post("/uploadFile", function(req,res){

		srcFiles = [];

		if (req.files.files[0][0]===undefined){
			srcFiles[0] = req.files.files[0];
		} else {
			srcFiles = req.files.files[0];
		}

		len = srcFiles.length;
		while(len--){

			var srcFile = srcFiles[len];
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
		res.send("success");
	});

	//## API
	app.get('/files', function(req, res) {
		db.File.find().limit(20).execFind(function(arr, data) {
			res.send(data);
		});
	});

	//## API
	app.post('/files', function(req, res) {

		file = new db.File();
		filename = 'copy_'+Date.now()+'_'+ req.body.name;
		fs.writeFileSync('./public/files/' + filename, fs.readFileSync('./public/files/' + req.body.name));

		file.name = filename;
		file.type = req.body.type;
		file.link = './static/files/' + filename;
		file.info = req.body.info;
		file.alt = req.body.alt;
		file.desc = req.body.desc;
		file.parent = req.body.parent;
		file.relation = req.body.relation;
		file.key = req.body.key;

		file.save(function(){
			res.send(file);
		});


	});

	app.put('/files/:id', function(req, res){
		db.File.findById(req.params.id, function(e, a) {
			if(a.name!=req.body.name) {
				link = './public/files/' + a.name;
				targetLink = './public/files/' + req.body.name;

				if (fs.existsSync(targetLink)===true) {
					name = 'copy_'+Date.now()+'_'+ req.body.name;
					targetLink = './public/files/' + name;
				}

				fs.renameSync(link, targetLink);
				a.link = './static/files/' + req.body.name;

			}

			a.name = req.body.name;
			a.info = req.body.info;
			a.alt = req.body.alt;
			a.desc = req.body.desc;
			a.parent = req.body.parent;
			a.relation = req.body.relation;
			a.key = req.body.key;

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

