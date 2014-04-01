var db = require(__dirname + '/model/StaticBlockSchema');

module.exports.setup = function(app) {

	// Insert Frontend Layout Data
	db.StaticBlock.count({},function(count) {
		if (count == 0) {
			// TODO
			// import ./data/staticblocks.bson
		}
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





