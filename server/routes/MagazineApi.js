var db = require('./../models');

module.exports.postMagazines = function(req, res){
	var magazine = new db.Magazine(); 
	magazine.title = req.body.title;
	magazine.editorial = req.body.editorial;
	magazine.impressum = req.body.impressum;
	magazine.cover = req.body.cover;
	magazine.back = req.body.back;
	magazine.pages = req.body.pages;
	magazine.date = new Date();
	magazine.save(function () {
		res.send(magazine);
	});
};

module.exports.updateMagazine = function(req, res){
	db.Magazine.findById( req.params.id, function(e, magazine) { 
		magazine.title = req.body.title;
		magazine.editorial = req.body.editorial;
		magazine.impressum = req.body.impressum;
		magazine.cover = req.body.cover;
		magazine.back = req.body.back;
		magazine.pages = req.body.pages;
		magazine.date = new Date();
		magazine.save();
  	});	
};

module.exports.deleteMagazine = function(req, res){
  	db.Magazine.findById( req.params.id, function(e, magazine) { 		
		magazine.remove();
  	});
};

module.exports.getMagazines = function(req, res){
  	db.Magazine.find().limit(20).execFind(function (arr,data) {
    	res.send(data);
  	});
};