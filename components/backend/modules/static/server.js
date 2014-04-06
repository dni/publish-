var db = require(__dirname + '/model/StaticBlockSchema'),
	fs = require("fs-extra");

module.exports.setup = function(app) {

	// Insert Frontend Layout Data
	db.StaticBlock.count({},function(err, count) {
		if (count == 0) importLayoutData();
	});

	// API
	app.get('/staticBlocks', function(req, res){
	  	db.StaticBlock.find().limit(20).execFind(function (arr,data) {
	    	res.send(data);
	  	});
	});

	app.get('/staticBlocks/:id', function(req, res){
	  	db.StaticBlock.findOne( {key:req.params.id}, function(e, a) {
	    	res.send(a.data);
	  	});
	});

	app.get('/exportStaticBlocks/', function(req, res){

		if (fs.existsSync(__dirname+'/data/publish/staticblocks.json')) {
			fs.unlinkSync(__dirname+'/data/publish/staticblocks.json');
		}

	  	var spawn = require('child_process').spawn;
		var mongoimport = spawn('mongoexport', ['-d', 'publish', '-c', 'staticblocks', '-o', 'staticblocks.json'], {cwd:__dirname+'/data'});

		mongoimport.on('exit', function (code) {
		    if(code !== 0) {
		    	res.send('Error: while exporting Static Blocks, code: ' + code);
		        console.log('Error: while exporting Static Blocks, code: ' + code);
		    } else {
		    	res.send("Exported Static Blocks");
		    	console.log("Exported Static Blocks");
		    }
		});
	});

	app.post('/staticBlocks', function(req, res){
		var a = new db.StaticBlock();
		a.title = req.body.title;
		a.key = req.body.key;
		a.data = req.body.data;
		a.deleteable = req.body.deleteable;

		a.save(function () {
			res.send(a);
		});
	});


	app.put('/staticBlocks/:id', function(req, res){
		db.StaticBlock.findById( req.params.id, function(e, a) {
			a.title = req.body.title;
			a.key = req.body.key;
			a.data = req.body.data;
			a.deleteable = req.body.deleteable;

			a.save(function () {
				res.send(a);
			});
	  	});
	});

	app.delete('/staticBlocks/:id', function(req, res){
	  	db.StaticBlock.findById( req.params.id, function(e, a) {

			return a.remove(function (err) {
		      if (!err) {
		        return res.send('');
		      } else {
		        console.log(err);
		      }
		    });
	  	});
	});

};

function importLayoutData(){

	var spawn = require('child_process').spawn;
	var mongoimport = spawn('mongoimport', ['--db', 'publish', '--collection', 'staticblocks', '--file', 'staticblocks.json'], {cwd:__dirname+'/data/'});

	mongoimport.on('exit', function (code) {
	    if(code !== 0) {
	        console.log('Error: while importing Static Blocks, code: ' + code);
	    } else {
	    	console.log("Imported Static Blocks");
	    }
	});

};





