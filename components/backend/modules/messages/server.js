var Message = require(__dirname + '/model/Schema'),
	fs = require("fs");

module.exports.setup = function(app) {

	app.get('/messages', function(req, res) {
		Message.find().sort({date: -1}).limit(50).execFind(function(arr, data) {
			res.send(data);
		});
	});

	app.post('/messages', function(req, res) {

		message = new Message();
		message.date = req.body.date;
		message.message = req.body.message;
		message.username = req.body.username;
		message.additionalinfo = req.body.additionalinfo;
		message.type = req.body.type;

		// log every message
		console.log(message);

		message.save(function(){
			req.io.broadcast('updateCollection', 'Messages');
			res.send(message);
		});
	});

	app.delete('/messages/:id', function(req, res){
	  	Message.findById( req.params.id, function(e, a) {
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

