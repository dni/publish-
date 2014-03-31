var fs = require('fs-extra'),
	gm = require('gm').subClass({ imageMagick: true }),
	Files = require('./../../files/model/FileSchema');
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
		if (error) return console.log('err', error);


		fs.remove('./public/files/iconset', function(err){
			if (err) { return console.error(err); }
			fs.mkdirs('./public/files/iconset', function(err){
				if (err) {return console.error(err);}
				else {
					console.log("iconset directory is clean, start with generating icons");
					startGenIconssets();
				}
			});
		});

		function startGenIconssets(){
			var formats = ["icon", "newsstand", "shelf", "launch"];
			var len = formats.length;
			while(len--){
				Files.File.findOne({relation: 'setting:'+setting._id, key: formats[len]}).exec(function(err, file){
					if (file!==null) { createIconSet(file.name, formats[len]); }
					else {console.log("some went wrong with startGenIconssets in BakerGenerator, err=", err);}
				});
			}
		}

		createBakerUiConstants();


		var action = setting.settings.apptype.value;
		switch (action) {
			case "standalone":
				buildStandalone(); break;
			case "newsstand":
				buildNewstand(); break;
			case "newsstandpaid":
				buildNewsstandpaid(); break;
		}

		// var exec = require("child_process").exec;
		// var child = exec('rm ./publish-baker -r',
		  // function (error, stdout, stderr) {
		    // console.log('stdout: ' + stdout);
		    // console.log('stderr: ' + stderr);
		    // if (error !== null) {
		      // console.log('exec error: ' + error);
		    // }
			// cb();
		// }, {cwd:__dirname});

	});
}


function createIconSet(filename, type) {
	var len = sizeList[type].length;
	// obtain the size of an image
	gm('./public/files/'+ filename).size(function (err, size) {
	  if (err) { return console.log(err); }
	  return generateIcons(size);
	});
	function generateIcons(size){
		while(len--){
			console.log("icon nr. ", len, " size ", size);

			var icon = sizeList[type][len];
			var image = gm('./public/files/'+ filename);

			if (type==="launch") {
				image.crop(icon.w, icon.h, (size.width-(icon.w))/2, (size.height-(icon.h))/2);
			} else if (type=="shelf") {
				image.crop(icon.w, icon.h, (size.width-(icon.w))/2, 0);
			} else if (type=="icon") {
				image.resize(icon.w, icon.h);
			} else if (type=="newsstand") {
				if (icon.w!==480) {
					if (icon.w < icon.h) {
						image.resize(0, icon.h);
					} else {
						image.resize(icon.w, 0);
					}
					image.crop(icon.w, icon.h, icon.w/2, 0);
				}
			}
			image.write('./public/files/iconset/'+ icon.n +"-"+ filename, function (err) {
			  if (err) { return console.log(err); }
			});
		}
	}
}


function buildStandalone(){

	fs.copySync(__dirname+'/baker-master', __dirname+'/publish-baker');

	replaceInTextFile(__dirname+'/publish-baker/BakerShelf/BakerIssue.h', { from:'#define BAKER_NEWSSTAND', to: '//#define BAKER_NEWSSTAND' });

	var files = fs.readdirSync('./public/books');
	for (key in files) {
		var file = files[key];
		if(file == '.DS_Store') continue;
		fs.copySync('./public/books/'+file+'/hpub', __dirname+'/publish-baker/books/'+file);
	}


};

function buildNewstand(){
	Settings.findOne({name:'MagazineModule'}).exec(function(error, setting){
		replaceInTextFile(__dirname+'/publish-baker/BakerShelf/Constants.h', {
			from:'#define NEWSSTAND_MANIFEST_URL @"http://bakerframework.com/demo/shelf.json"',
			to: '#define NEWSSTAND_MANIFEST_URL @"http://'+setting.settings.domain.value+'/books/shelf.json"'
		});
	});
};

function buildNewstandpaid(){

};

var sizeList = {
	launch : [
		// launch images
		{ n: "iPad Landscape iOS6 no status bar", w: 1024, h: 748},
		{ n: "iPad Landscape iOS6 no status bar@2x-1", w: 2048, h: 1496},
		{ n: "iPad Landscape iOS7", w: 1024, h: 768},
		{ n: "iPad Landscape iOS7 2x", w: 2048, h: 1536},
		{ n: "iPad Portrait iOS6 no status bar", w: 768, h: 1004},
		{ n: "iPad Portrait iOS6 no status bar@2x", w: 1536, h: 2008},
		{ n: "iPad Portrait iOS7", w: 768, h: 1024},
		{ n: "iPad Portrait iOS7@2x", w: 1536, h: 2048},
		{ n: "iPhone Portrait iOS7 R4", w: 640, h: 1136},
		{ n: "iPhone Portrait iOS7@2x ", w: 640, h: 960},
	],
	icon : [
		// app iconset
		{ n: "iPad App iOS6", w: 72, h: 72},
		{ n: "iPad App iOS6@2x", w: 144, h: 144},
		{ n: "iPad App iOS7", w: 76, h: 76},
		{ n: "iPad App iOS7@2x", w: 152, h: 152},
		{ n: "iPhone App iOS6", w: 57, h: 57},
		{ n: "iPhone App iOS6@2x", w: 114, h: 114},
		{ n: "iPhone App iOS7@2x", w: 120, h: 120},
	],
	newsstand : [
		// Newsstand icons
		{ n: "newsstand-app-icon", w: 112, h: 126},
		{ n: "newsstand-app-icon@2x", w: 224, h: 252},
		{ n: "shelf-bg-landscape~iphone", w: 480, h: 268},
	],
	shelf: [
		// Shelf Bg
		{ n: "shelf-bg-landscapel-568h", w: 1136, h: 536},
		{ n: "shelf-bg-landscape@2x~ipad", w: 2048, h: 1407},
		{ n: "shelf-bg-landscape@2x~iphone", w: 960, h: 536},
		{ n: "shelf-bg-landscape~ipad", w: 1024, h: 704},
		{ n: "shelf-bg-portrait-568h", w: 640, h: 1008},
		{ n: "shelf-bg-portrait@2x~ipad", w: 1536, h: 1920},
		{ n: "shelf-bg-portrait@2x~iphone", w: 640, h: 832},
		{ n: "shelf-bg-portrait~ipad", w: 768, h: 960},
		{ n: "shelf-bg-portrait~iphone", w: 320, h: 416}
	]
};

function createBakerUiConstants(){
	Settings.findOne({name:'MagazineModule'}).exec(function(err, setting){
		if (err) { return console.log(err); }
		else {
			var settings = setting.settings;
			var txt = '#ifndef Baker_UIConstants_h\n#define Baker_UIConstants_h';
			txt += '\n\t#define ISSUES_COVER_BACKGROUND_COLOR @"'+settings.backerColorsetCoverBg.value+'"';
			txt += '\n\t#define ISSUES_TITLE_COLOR @"'+settings.backerColorsetTitleColor.value+'"';
			txt += '\n\t#define ISSUES_INFO_COLOR @"'+settings.backerColorsetInfoColor.value+'"';
			txt += '\n\t#define ISSUES_PRICE_COLOR @"'+settings.backerColorsetPriceColor.value+'"';
			txt += '\n\t#define ISSUES_ACTION_BUTTON_BACKGROUND_COLOR @"'+settings.backerColorsetActionButtonBg.value+'"';
			txt += '\n\t#define ISSUES_ACTION_BUTTON_COLOR @"'+settings.backerColorsetActionButtonColor.value+'"';
			txt += '\n\t#define ISSUES_ARCHIVE_BUTTON_COLOR @"'+settings.backerColorsetArchiveButtonBg.value+'"';
			txt += '\n\t#define ISSUES_ARCHIVE_BUTTON_BACKGROUND_COLOR @"'+settings.backerColorsetArchiveButtonColor.value+'"';
			txt += '\n\t#define ISSUES_LOADING_LABEL_COLOR @"'+settings.backerColorsetLoadingLabelColor.value+'"';
			txt += '\n\t#define ISSUES_LOADING_SPINNER_COLOR @"'+settings.backerColorsetLoadingSpinnerColor.value+'"';
			txt += '\n\t#define ISSUES_PROGRESSBAR_TINT_COLOR @"'+settings.backerColorsetProgressbarTintColor.value+'"';
			txt += '\n#endif';

			fs.writeFile(__dirname+'/baker-master/BakerShelf/UIConstants.h.edited', txt, function(err) {
			    if(err) { console.log("Baker_UIConstants_h save error: ",err); }
			    else { console.log("Baker_UIConstants_h was saved!"); }
			});
		}
	});
};

function replaceInTextFile(fileToEdit, changes) {
	fs.readFile(fileToEdit, function(err, res) {
	    if(err) { console.log("BakerGenerator replaceInTextFile readFile error: ",err); }
	    else {
	    	txt = res.toString();
	    	txt = txt.replace(changes.from, changes.to);
			fs.writeFile(fileToEdit+".edited" , txt, function(err) {
			    if(err) { console.log("save error: ",err); }
			});
	    }
	});
};
