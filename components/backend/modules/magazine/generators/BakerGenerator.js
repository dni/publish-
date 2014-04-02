var fs = require('fs-extra'),
	gm = require('gm'),
	Files = require('./../../files/model/FileSchema'),
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
		if (error) return console.log('prepareDownload err=', error);

		var child_process = require('child_process').spawn;
	    var spawn = child_process('rm', ['-rf', '-', 'publish-baker'], {cwd:__dirname});

	    spawn.on('exit', function (code) {
	        if(code !== 0) {
	            res.statusCode = 500;
	            console.log('remove files (rm) process exited with code ' + code);
	        } else {
	        	console.log("remove files (rm)  done");

				fs.copySync(__dirname+'/baker-master', __dirname+'/publish-baker');

				startGenIconssets(setting);

				createBakerUiConstants();

				var action = setting.settings.apptype.value;
				switch (action) {
					case "standalone":
						buildStandalone(); break;
					case "newsstand":
						buildNewstand(settings); break;
					case "newsstandpaid":
						buildNewsstandpaid(); break;
				}

					// cb();
	        }

	    });

	});
}

function buildStandalone(){

	replaceInTextFile(__dirname+'/publish-baker/BakerShelf/BakerIssue.h', { from:'#define BAKER_NEWSSTAND', to: '//#define BAKER_NEWSSTAND' });

	var files = fs.readdirSync('./public/books');
	for (key in files) {
		if(files.hasOwnProperty(key)){
			var file = files[key];
			if(file === '.DS_Store') continue;
			fs.copySync('./public/books/'+file+'/hpub', __dirname+'/publish-baker/books/'+file);
		}
	}
};

function buildNewstand(settings){
	replaceInTextFile(__dirname+'/publish-baker/BakerShelf/Constants.h', {
		from:'#define NEWSSTAND_MANIFEST_URL @"http://bakerframework.com/demo/shelf.json"',
		to: '#define NEWSSTAND_MANIFEST_URL @"http://'+setting.settings.domain.value+'/books/shelf.json"'
	});
};

function buildNewstandpaid(){};

var sizeList = {
	launch : [
		// launch images
		{ n: "iPad Landscape iOS6 no status bar", w: 1024, h: 748},
		{ n: "iPad Landscape iOS6 no status bar@2x", w: 2048, h: 1496},
		{ n: "iPad Landscape iOS7", w: 1024, h: 768},
		{ n: "iPad Landscape iOS7@2x", w: 2048, h: 1536},
		{ n: "iPad Portrait iOS6 no status bar", w: 768, h: 1004},
		{ n: "iPad Portrait iOS6 no status bar@2x", w: 1536, h: 2008},
		{ n: "iPad Portrait iOS7", w: 768, h: 1024},
		{ n: "iPad Portrait iOS7@2x", w: 1536, h: 2048},
		{ n: "iPhone Portrait iOS7 R4", w: 640, h: 1136},
		{ n: "iPhone Portrait iOS7@2x", w: 640, h: 960}
	],
	icon : [
		// app iconset
		{ n: "iPad App iOS6", w: 72, h: 72},
		{ n: "iPad App iOS6@2x", w: 144, h: 144},
		{ n: "iPad App iOS7", w: 76, h: 76},
		{ n: "iPad App iOS7@2x", w: 152, h: 152},
		{ n: "iPhone App iOS6", w: 57, h: 57},
		{ n: "iPhone App iOS6@2x", w: 114, h: 114},
		{ n: "iPhone App iOS7@2x", w: 120, h: 120}
	],
	newsstand : [
		// Newsstand icons
		{ n: "newsstand-app-icon", w: 112, h: 126},
		{ n: "newsstand-app-icon@2x", w: 224, h: 252},
		{ n: "shelf-bg-landscape~iphone", w: 480, h: 268}
	],
	shelf: [
		// Shelf Bg
		{ n: "shelf-bg-landscape-568h", w: 1136, h: 536},
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

function startGenIconssets(setting){
	var formats = ["icon", "newsstand", "shelf", "launch"];
	var len = formats.length;
	while(len--) {
		var format = formats[len];
		Files.File.findOne({relation: 'setting:'+setting._id, key: format}).exec(function(err, file) {
			if (file!==null) {
				createIconSet(file.name, file.key); }
			else {return console.error("some went wrong with startGenIconssets in BakerGenerator, err=", err);}
		});
	}
}
function createIconSet(filename, format) {
	var len = sizeList[format].length-1,
	filetype, targetImageLink, icon, targetDir, size;
	function generateIcons(size){
		var image = gm('./public/files/'+ filename);
		icon = sizeList[format][len];
		targetDir = __dirname+'/publish-baker/Baker/BakerAssets.xcassets/'
		filetype = filename.split(".");
		filetype = filetype[filetype.length-1];
		if (format==="launch") {
			image.crop(icon.w, icon.h, (size.width-(icon.w))/2, (size.height-(icon.h))/2);
			targetDir += "LaunchImage.launchimage"
		} else if (format==="shelf") {
			image.crop(icon.w, icon.h, (size.width-(icon.w))/2, 0);
			if (icon.n.indexOf("portrait")>1) { targetDir += "shelf-bg-portrait.imageset"; }
			else { targetDir += "shelf-bg-landscape.imageset"; }
		} else if (format==="icon") {
			image.resize(icon.w, icon.h);
			targetDir += "AppIcon.appiconset"
		} else if (format==="newsstand") {
			if (icon.w!==480) {
				if (icon.w < icon.h) { image.resize(0, icon.h); }
				else { image.resize(icon.w, 0);	}
				image.crop(icon.w, icon.h, icon.w/2, 0);
			}
			if (icon.n.indexOf("landscape")>1) { targetDir += "shelf-bg-landscape.imageset";}
			else { targetDir += "newsstand-app-icon.imageset";}
		}

		targetImageLink = targetDir +"/"+ icon.n +"."+ filetype;

		image.write(targetImageLink, function (err) {
		  if (err) { return console.error("icon.write err=", err); }
		  len--;
		  if (len>=0) { generateIcons(size); }
		});
	};
	// obtain the size of an image
	gm('./public/files/'+ filename).size(function (err, size) {
	  if (err) { return console.log("createIconSet getSize err=",err); }
	  return generateIcons(size);
	});
};


function createBakerUiConstants(){
	Settings.findOne({name:'MagazineModule'}).exec(function(err, setting){
		if (err) { return console.error("createBakerUiConstants findOne err=", err); }
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

			fs.writeFile(__dirname+'/publish-baker/BakerShelf/UIConstants.h', txt, function(err) {
			    if(err) { console.error("Baker_UIConstants_h save error: ",err); }
			    else { console.log("Baker_UIConstants_h was saved!"); }
			});
		}
	});
};

function replaceInTextFile(fileToEdit, changes) {
	fs.readFile(fileToEdit, function(err, res) {
		if(err) { console.log("BakerGenerator replaceInTextFile readFile error: ",err); }
		else {
			var txt = res.toString();
			txt = txt.replace(changes.from, changes.to);
			fs.writeFile(fileToEdit+".edited" , txt, function(err) {
			    if(err) { console.error("BakerGenerator replaceInTextFile save error: ",err); }
			});
		}
	});
};

