var db = require('./../settings/model/SettingSchema'),
	http = require("http"),
	ApnToken = require(__dirname + "/model/ApnTokenSchema"),
	Issue = require(__dirname + "/model/IssueSchema"),
	PurchasedIssue = require(__dirname + "/model/PurchasedIssueSchema"),
	Receipt = require(__dirname + "/model/ReceiptSchema"),
	BakerGenerator = require(__dirname + "/generators/BakerGenerator");

module.exports.setup = function(app) {

	app.get('/downloadApp', BakerGenerator.download);

	// API
	app.post('/purchase_confirmation', function(req, res){

		receipt = new Receipt();
		receipt.app_id = req.body.app_id;
		receipt.user_id = req.body.user_id;
		receipt.purchase_type = req.body.purchase_type;
		receipt.base64_receipt = req.body.base64_receipt;

		var options = {
	      host: 'sandbox.itunes.apple.com',
	      port: '80',
	      path: '/verifyReceipt',
	      method: 'POST'
		};

		var post = http.request(options, function(res) {
			console.log("verify user res: ", res);
			if (!res.data || (res.data.status != 0 && data.status != 21006)) {
				console.log("Invalid receipt for $product_id : status " + data.status);
			}
		});

	    post.write({
			receipt_data: receipt.base64_receipt,
			password: 'dnilabs'
		}).end();

		console.log("Saving "+receipt.purchase_type+" "+''+" app:"+receipt.app_id+" user:"+receipt.user_id+" in the receipt database");

		res.end();

	});



	app.post('/post_apns_token', function(req, res){

		var token = new ApnToken();

		token.app_id = req.body.app_id;
		token.apns_token = req.body.apns_token;
		token.user_id = req.body.user_id;

		console.log("/post_apns_token: "+token.apns_token+" app:"+token.app_id+" user:"+token.user_id+" in the database");

		token.save(function(){
			res.end();
		});

	});

	app.get("/shelf", function(req,res){

		db.Magazine.find({published:1}).execFind(function (arr, magazines) {
			var json = [];
			_.each(magazines, function(magazine){
				json.push({
				    "name": magazine.title,
				    "title": magazine.title,
				    "info": "The original masterpiece by Sir A. Conan Doyle",
				    "date": "1887-10-10 10:10:10",
				    "cover": "http://bakerframework.com/newsstand-books/a-study-in-scarlet.png",
				    "url": "http://bakerframework.com/newsstand-books/a-study-in-scarlet.hpub",
				    "product_id": "com.example.Baker.issues.january2013"
			 	});
			});
			res.send(JSON.stringify(json));
	  	});

	});


	// endpoint for downloading hpub file (zip)
	app.get("/issue", function(req, res) {

		// only free issues so far

		var spawn = require('child_process').spawn;
	    var zip = spawn('zip', ['-r', '-', 'hpub'], {cwd:'./public/books/'+req.body.name});

	    res.contentType('zip');

	    zip.stdout.on('data', function (data) {
	        res.write(data);
	    });

	    zip.on('exit', function (code) {
	        if(code !== 0) {
	            res.statusCode = 500;
	            console.log('zip process exited with code ' + code);
	            res.end();
	        } else {
	        	console.log("zip done");
	            res.end();
	        }
	    });
	});
};

