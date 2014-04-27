var fs = require('fs-extra'),
	gm = require('gm'),
	Files = require('./../../files/model/FileSchema'),
	emitter = require('events').EventEmitter,
	ejs = require("ejs"),
	EE = new emitter(),
	Settings = require('./../../settings/model/SettingSchema');


module.exports.download = function(req, res){

	// when every task is ready, send zip
	EE.removeAllListeners('ready');
	var tasks = ['icon', 'build', 'constants'];
	EE.on("ready", function(task) {
		tasks.splice(tasks.indexOf(task), 1);
		if (!tasks.length) {
			var spawn = require('child_process').spawn;
		    // Options -r recursive -j ignore directory info - redirect to stdout
		    var zip = spawn('zip', ['-r', '-', 'publish-baker'], {cwd:'./cache'});
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
		    zip.on('close', function (code) {
		        if(code !== 0) {
		            // res.statusCode = 500;
		            console.log('zip process exited with code ' + code);
		            res.end();
		        } else {
		        	console.log("download app zip done");
		            res.end();
		        }
		    });
		}

	});

	prepareDownload();
};


function prepareDownload(){
	Settings.findOne({name:'Baker'}).exec(function(error, setting){

		// delete dirty baker project
		var child_process = require('child_process').spawn;
	    var spawn = child_process('rm', ['-rf', '-', 'publish-baker'], {cwd:process.cwd() + "/cache"});

	    spawn.on('exit', function (code) {
	        if(code !== 0) {
	            // res.statusCode = 500;
	            console.log('remove cache/publish-baker (rm) process exited with code ' + code);
	        } else {

				var dirname = process.cwd()+"/cache/publish-baker";
				fs.copySync(process.cwd()+'/baker-master', dirname);

				startGenIconssets(setting);

				Settings.findOne({name:'General'}).exec(function(error, generalsetting){

					// Constants
					template = fs.readFileSync(__dirname+'/templates/Constants.h', 'utf-8');
					fs.writeFileSync(dirname+'/BakerShelf/Constants.h', ejs.render(template, { settings: setting.settings, domain:generalsetting.settings.domain.value}));

					// Ui constants
					template = fs.readFileSync(__dirname+'/templates/UIConstants.h', 'utf-8');
					fs.writeFileSync(dirname+'/BakerShelf/UIConstants.h', ejs.render(template, { settings: setting.settings}));


					// Baker-Info.plist
					template = fs.readFileSync(__dirname+'/templates/Baker-Info.plist', 'utf-8');
					fs.writeFileSync(dirname+'/Baker/Baker-Info.plist', ejs.render(template, { settings: setting.settings, domain:generalsetting.settings.domain.value}));

					EE.emit("ready", "constants");
				});

				var action = setting.settings.apptype.value;
				if (action == "standalone") {
					var files = fs.readdirSync('./public/books');
					for (key in files) {
						if(files.hasOwnProperty(key)){
							var file = files[key];
							if(file === '.DS_Store') continue;
							if(file === '.gitignore') continue;
							fs.copySync('./public/books/'+file+'/hpub', dirname+'/books/'+file);
						}
					}
				}

				EE.emit('ready', 'build');
	        }
	    });
	});
}


function startGenIconssets(setting){

	var formats = ["icon", "newsstand", "shelf", "launch"];
	var sizeList = getSizeList();

	function createIcons(format) {
		Files.File.findOne({relation: 'setting:'+setting._id, key: format}).exec(function(err, file) {
			if (file) {
				var filename = file.name, targetImageLink, icon, targetDir, size;
				var image = gm('./public/files/'+ filename);
				var filetype = filename.split(".").pop();

				// obtain the size of an image
				gm('./public/files/'+ filename).size(function (err, size) {

					if (err) { return console.log("createIconSet getSize err=",err); }

					var iconInfos = sizeList[format];

					function createIcon(icon) {

						targetDir = './cache/publish-baker/Baker/BakerAssets.xcassets/';


						if (format==="launch") {
							image.crop(icon.w, icon.h, (size.width-(icon.w))/2, (size.height-(icon.h))/2);
							targetDir += "LaunchImage.launchimage";

						} else if (format==="shelf") {
							image.crop(icon.w, icon.h, (size.width-(icon.w))/2, 0);
							if (icon.n.indexOf("portrait")>1) { targetDir += "shelf-bg-portrait.imageset"; }
							else { targetDir += "shelf-bg-landscape.imageset"; }

						} else if (format==="icon") {
							image.resize(icon.w, icon.h);
							targetDir += "AppIcon.appiconset";

						} else if (format==="newsstand") {
							if (icon.w!==480) {
								if (icon.w < icon.h) { image.resize(0, icon.h); }
								else { image.resize(icon.w, 0);	}
								image.crop(icon.w, icon.h, icon.w/2, 0);
							}
							if (icon.n.indexOf("landscape")>1) { targetDir += "shelf-bg-landscape.imageset";}
							else { targetDir += "newsstand-app-icon.imageset";}
						}

						targetImageLink = targetDir +"/"+ icon.n +".png";


						console.log(format, icon, icon.n +"."+ filetype);

						image.write(targetImageLink, function (err) {
						  if (err) { return console.error("icon.write err=", err); }
							if (iconInfos.length > 0) {
								// next icon for format
								createIcon(iconInfos.pop());
							}
							else {
								if (formats.length > 0) {
									// next format
									createIcons(formats.pop());
								} else {
									// done with image generation
									EE.emit('ready', 'icon');
								}
							}
						});

					};
					createIcon(iconInfos.pop());

				});

			}
			else {
				// no file for format found
				if (formats.length > 0) {
					// next format
					createIcons(formats.pop());
				} else {
					// done with image generation
					EE.emit('ready', 'icon');
				}

				console.error("some went wrong with startGenIconssets in BakerGenerator, err=", err);
			}
		});
	};

	createIcons(formats.pop());
}
function getSizeList() {
	return {
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
}

