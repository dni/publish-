var fs = require('fs-extra'),
	gm = require('gm'),
	File = require('./../../files/model/FileSchema'),
	emitter = require('events').EventEmitter,
	ejs = require("ejs"),
	EE = new emitter(),
	Settings = require('./../../settings/model/SettingSchema');
	StaticBlocks = require('./../../static/model/StaticBlockSchema');


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
					// info menu
					StaticBlocks.findOne({key:'info'}).exec(function(err, block){
						if(err){throw(err);}
						else {
							template = fs.readFileSync(__dirname+'/templates/info.html', 'utf-8');
							fs.writeFileSync(
								dirname+'/BakerShelf/info/info.html',
								ejs.render(
									template,
									{ block: block.data }
								)
						);
						}
					});


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

	var formats = ["shelf", "launch", "icon"];
	var sizeList = getSizeList();
	var background, logo, icon;

	File.findOne({relation: 'setting:'+setting._id, key: "background"}).exec(function(err, file) {
		File.findOne({relation: 'setting:'+setting._id, key: "logo"}).exec(function(err, file) {
			logo =  file.name;
			File.findOne({relation: 'setting:'+setting._id, key: "icon"}).exec(function(err, file) {
				icon =  file.name;
				createIcons(formats.pop());
			});
		});
	});

	function createIcons(format) {

		format=="icon" ? key="icon" : key="logo"
		key==="logo" ? size={width:1024,height:768} : size={width:286,height:286}
		var targetImageLink = ""
		, image = gm()
		, filetype = "png"//file.name.split(".").pop();
		, iconInfos = sizeList[format];

		function createIcon(imgData) {

			targetDir = './cache/publish-baker/Baker/BakerAssets.xcassets/';

			if (format==="icon") {
				image = gm('./public/files/'+ icon)

				if(imgData.h>imgData.w){
					//image.resize(imgData.w, imgData.h, "!");
					image.resize(imgData.w);
					image.extent(imgData.w, imgData.h);
					image.in("-background", "transparent");
					targetDir += "newsstand-app-icon.imageset";
				} else {
					image.resize(imgData.w);
					targetDir += "AppIcon.appiconset";
				}
				writeImage(image);
			}else{
				newImg = "tmpImg."+logo.split(".").pop();
				newBg = "tmpBg."+background.split(".").pop();
				gm('./public/files/'+ logo).resize(imgData.w/3)
					.write('./public/files/'+newImg, function(){
						gm('./public/files/'+ background).crop(imgData.w, imgData.h, (1024-imgData.w/2), (1024-imgData.h/2))
							.write('./public/files/'+newBg, function(){
								if (format==="shelf") {
									image//.resize(imgData.w, imgData.h)
										.in('-page', '+0+0')  // Custom place for each of the images
										.in('./public/files/'+ newBg)
										.in('-page', '+'+((imgData.w-imgData.w/3)/2)+'+'+((imgData.h-imgData.h/4)/3)+'')  // Custom place for each of the images
										.in('./public/files/'+ newImg)
										.flatten()
									if (imgData.n.indexOf("portrait")>1) { targetDir += "shelf-bg-portrait.imageset"; }
									else { targetDir += "shelf-bg-landscape.imageset"; }
									writeImage(image);
								} else if (format=="launch") {
									image//.resize(imgData.w, imgData.h)
										.in('-page', '+0+0')  // Custom place for each of the images
										.in('./public/files/'+ newBg)
										.in('-page', '+'+((imgData.w-imgData.w/3)/2)+'+'+((imgData.h-imgData.h/4)/3)+'')  // Custom place for each of the images
										.in('./public/files/'+ newImg)
										.flatten()
									targetDir += "LaunchImage.launchimage";
									writeImage(image);
								}
							});
					});
			}
			function writeImage(image){
				targetImageLink = targetDir +"/"+ imgData.n +"."+ filetype;
				console.log(format, imgData, imgData.n +"."+ filetype);
				console.log(background ,logo, icon)
				image.write(targetImageLink, function (err) {
				  if (err) { return console.error("icon.write err=", err); }
					if (iconInfos.length > 0) { createIcon(iconInfos.pop()); }
					else {
						if (formats.length > 0) { createIcons(formats.pop()); }
						else { EE.emit('ready', 'icon'); }
					}
				});
			}
		};
		createIcon(iconInfos.pop());
	}
}


function getSizeList() {
	return {
		icon : [
			{ n: "iPad App iOS6", w: 72, h: 72},
			{ n: "iPad App iOS6@2x", w: 144, h: 144},
			{ n: "iPad App iOS7", w: 76, h: 76},
			{ n: "iPad App iOS7@2x", w: 152, h: 152},
			{ n: "iPhone App iOS6", w: 57, h: 57},
			{ n: "iPhone App iOS6@2x", w: 114, h: 114},
			{ n: "iPhone App iOS7@2x", w: 120, h: 120},
			{ n: "newsstand-app-icon", w: 112, h: 126},
			{ n: "newsstand-app-icon@2x", w: 224, h: 252}
		],
		launch : [
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
		shelf: [
			{ n: "shelf-bg-landscape~iphone", w: 480, h: 268},
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
