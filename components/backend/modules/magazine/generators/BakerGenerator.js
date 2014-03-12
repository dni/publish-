var fs = require('fs'),
	_ = require('underscore'),
	ejs = require('ejs'),
	db = require('./../model/MagazineSchema');
	db2 = require('./../../article/model/ArticleSchema');

module.exports.download = function(req, res){
		
	var spawn = require('child_process').spawn;
    // Options -r recursive -j ignore directory info - redirect to stdout
    var zip = spawn('zip', ['-r', '-', 'baker-master'], {cwd:__dirname});

    res.contentType('zip');

    // Keep writing stdout to res
    zip.stdout.on('data', function (data) {
        res.write(data);
    });

    zip.stderr.on('data', function (data) {
        // Uncomment to see the files being added
        console.log('zip stderr: ' + data);
    });

    // End the response on zip exit
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
};

module.exports.generate = function(res, magazine) {
	
};
