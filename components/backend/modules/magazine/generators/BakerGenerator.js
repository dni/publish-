var fs = require('fs'),
	fs_extra = require('fs-extra'),
	Settings = require('./../../settings/model/SettingSchema');

module.exports.download = function(req, res){

	prepareDownload(function(){
		var spawn = require('child_process').spawn;
	    // Options -r recursive -j ignore directory info - redirect to stdout
	    var zip = spawn('zip', ['-r', '-', 'publish-baker'], {cwd:__dirname});
	
	    res.contentType('zip');
	
	    // Keep writing stdout to res
	    zip.stdout.on('data', function (data) {
	        res.write(data);
	    });
	
	    zip.stderr.on('data', function (data) {
	        // Uncomment to see the files being added
	        // console.log('zip stderr: ' + data);
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
	});
	
};

function prepareDownload(cb){
	Settings.findOne({name:'MagazineModule'}).exec(function(error, setting){
		if (error) return console.log('err');
		
		
		var action = setting.settings.apptype.value;
// 		
		switch (action) {
			case "standalone":
				buildStandalone(); break;
			case "newsstand":
				buildNewstand(); break;
			case "newsstandpaid":
				buildNewsstandpaid(); break;
		}
		
		var exec = require("child_process").exec;
		var child = exec('rm ./publish-baker -r',
		  function (error, stdout, stderr) {
		    console.log('stdout: ' + stdout);
		    console.log('stderr: ' + stderr);
		    if (error !== null) {
		      console.log('exec error: ' + error);
		    }
			cb();
		}, {cwd:__dirname});
		
	});
	
}
function buildStandalone(){
	
	fs_extra.copySync(__dirname+'/baker-master', __dirname+'/publish-baker');
	
	var files = fs.readdirSync('./public/books');
	for (key in files) {
		var file = files[key];
		if(file == '.DS_Store') continue;
		fs_extra.copySync('./public/books/'+file+'/hpub', __dirname+'/publish-baker/books/'+file);
	}

	
}
function buildNewstand(){
	
}
function buildNewstandpaid(){
	
}
