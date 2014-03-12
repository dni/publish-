var db = require('./../model/MagazineSchema');
var fs = require('fs-extra');
var hpubGenerator = require('./../generators/HpubGenerator');


module.exports.initialize = function(req, res) {

	if (fs.existsSync("./public/magazines/" + req.body.title)) {
		db.Magazine.findOne({_id: req.body.id}).execFind(function (arr,data) {
			hpubGenerator.generate( res, data );
	  	});
		res.send("hpub generated");
		return;
	} else {
		res.send("error folder doesnt exists");
	}

};