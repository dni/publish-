var db = require(__dirname + '/model/FileSchema'),
	mongoose = require("mongoose");
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
		var send = function(arr, data) {
			res.send(data);
		};

		if (req.query.parents) {
			db.File.find({'parent':undefined}).execFind(send);
		} else {
			db.File.find().execFind(send);
		}

	});

	app.post('/files', function(req, res) {
		newfile = req.body;

		file = new db.File();
		filename = 'copy_'+Date.now()+'_'+ newfile.name;
		fs.writeFileSync('./public/files/' + filename, fs.readFileSync('./public/files/' + newfile.name));

		file.name = filename;
		file.type = newfile.type;
		file.link = './static/files/' + filename;
		file.info = newfile.info;
		file.alt = newfile.alt;
		file.desc = newfile.desc;
		file.parent = newfile.parent;
		file.relation = newfile.relation;
		file.key = newfile.key;

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

