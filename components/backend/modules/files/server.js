var File = require(__dirname + '/model/FileSchema'),
	Setting = require('./../settings/model/SettingSchema');
	gm = require('gm'),
	mongoose = require("mongoose"),
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
			var file = new File();
			var name = srcFile.name;
			var targetLink = './public/files/' + name;


			if (fs.existsSync(targetLink)===true) {
				name = 'copy_'+Date.now()+'_'+name;
				targetLink = './public/files/' + name;
			}

			file.name = name;
			file.type = srcFile.type;
			file.link = name;
			fs.renameSync(srcFile.path, targetLink);
			// fs.unlinkSync(srcFile.path);


			if (file.type.split("/")[0]=="image") {
				Setting.findOne({name: 'Files'}).execFind(function(err, setting){
					cfg = setting.pop();
					createImages(file, name, res, req, cfg);
				});
			} else {
				file.save(function(){
					req.io.broadcast('updateCollection', 'Files');
					res.send(file);
				});
			}


		}
		res.send("success");
	});

	//## API
	app.get('/files', function(req, res) {
		var send = function(arr, data) {
			res.send(data);
		};

		if (req.query.parents) {
			File.find({'parent':undefined}).execFind(send);
		} else {
			File.find().execFind(send);
		}

	});

	app.post('/files', function(req, res) {
		newfile = req.body;

		file = new File();
		filename = 'copy_'+Date.now()+'_'+ newfile.name;
		fs.writeFileSync('./public/files/' + filename, fs.readFileSync('./public/files/' + newfile.name));

		file.name = filename;
		file.type = newfile.type;
		file.link = filename;
		file.info = newfile.info;
		file.alt = newfile.alt;
		file.desc = newfile.desc;
		file.parent = newfile.parent;
		file.relation = newfile.relation;
		file.key = newfile.key;

		if (newfile.type.split("/")[0]=="image") {
			Setting.findOne({name: 'Files'}).execFind(function(err, setting){
				cfg = setting.pop();
				createImages(file, filename, res, req, cfg);
			});
			console.log("new");
		} else {
			file.save(function(){
				req.io.broadcast('updateCollection', 'Files');
				res.send(file);
			});
		}

	});

	function createImages(file, filename, res, req, cfg) {

		var types = ["thumbnail", "smallPic", "bigPic"];
		var image = gm('./public/files/'+ filename);


		image.size(function (err, size) {

			if (err) { return console.error("createWebPic getSize err=",err); }

			function shrinkPic(type) {

				var maxSize = cfg.settings[type].value;
				var targetName = type + "_thumb_" + filename;
				var targetLink = './public/files/'+ targetName;

				image.quality(parseInt(cfg.settings.quality.value));

				if (size.width>size.height){
					image.resize(maxSize);
				} else {
					image.resize(null, maxSize);
				}

				image.write(targetLink , function (err) {
				  if (err) { return console.error("image.write('./public/files/iconset/ err=", err); }
					file[type] = targetName;

				  if (types.length > 0) {
				  	shrinkPic(types.pop());
				  } else {
					file.save(function(){
						req.io.broadcast('updateCollection', 'Files');
						res.send(file);
					});
				  }

				});
			};

			shrinkPic(types.pop());


		});

	};

	app.put('/files/:id', function(req, res){
		File.findById(req.params.id, function(e, a) {
			if(a.name!=req.body.name) {
				link = './public/files/' + a.name;
				targetLink = './public/files/' + req.body.name;

				if (fs.existsSync(targetLink)===true) {
					name = 'copy_'+Date.now()+'_'+ req.body.name;
					targetLink = './public/files/' + name;
				}

				fs.renameSync(link, targetLink);
				a.link = req.body.name;

			}

			a.name = req.body.name;
			a.info = req.body.info;
			a.alt = req.body.alt;
			a.desc = req.body.desc;
			a.parent = req.body.parent;
			a.relation = req.body.relation;
			a.key = req.body.key;
			// a.thumbnail = req.body.thumbnail;
			// a.smallPic = req.body.smallPic;
			// a.bigPic = req.body.bigPic;
			a.save(function () {
				req.io.broadcast('updateCollection', 'Files');
				res.send(a);
			});
	  	});
	});

	app.delete('/files/:id', function(req, res) {
		Setting.findOne({name: 'Files'}).execFind(function(err, setting){
			cfg = setting.pop();
			File.findById(req.params.id, function(e, a) {
				if (fs.existsSync("./public/files/" + a.name)===true){
					fs.unlink("./public/files/" + a.name);
				}

				for (var index in cfg.settings) {

				    if (cfg.settings.hasOwnProperty(index)) {
						if (fs.existsSync("./public/files/" + a[index])===true){
							fs.unlink("./public/files/" + a[index]);
						}
				    }
				}

				return a.remove(function(err, model) {
					if (err) return console.log(err);
					return res.send('');
				});
			});
		});
	});

};

