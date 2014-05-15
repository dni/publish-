var child_process = require('child_process').spawn;
console.log("\x1b[40m\x1b[33m");
console.log('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n');
console.log('\x1b[33m\x1b[4mPUBLISH! INSTALLATION STARTED\x1b[24m');
console.log('\n\n\x1b[33mSTART NPM INSTALL');

var errorlog = ""




function end() {
	if(errorlog.length>0){
		console.log('\x1b[31mINSTALLATION HAS COMPLETED WITH ERRORS !!!');
		console.log(errorlog); 
	} else {
		console.log('\x1b[32m\x1b[5mINSTALLATION IS COMPLETE !!!');
	}
	console.log("\x1b[0m");
}


function gruntDev() {
	console.log('\x1b[33mSTART JAKE INSTALL');
	var jakeInstall = child_process('grunt', ['dev'], {cwd:'./'});
	jakeInstall.stdout.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
	jakeInstall.stderr.on('data', function (data) { console.log("\x1b[31m", data.toString()); });
	jakeInstall.on('close', function (code) {
		if (code==0) { console.log('\x1b[32mGRUNT DEV SUCCEEDED WITHOUT ERRORS');}
		else { errorlog+='\x1b[31mGRUNT DEV ERROR\n' }
		end();
	});
}
function bakermasterClone() {
	console.log('\n\x1b[33mSTART CLONE BAKER');
	var rmBakerDir = child_process('rm', ['-r', 'baker-master']);
	rmBakerDir.on('exit', function (code) {
		var bakermasterClone = child_process('git', ['clone', 'https://github.com/bakerframework/baker.git', 'baker-master']);
		console.log("\x1b[36m")
		bakermasterClone.stdout.on('data', function (data) { console.log(data.toString()); });
		bakermasterClone.stderr.on('data', function (data) { console.log(data.toString()); });
		bakermasterClone.on('close', function (code) {
		var rmDemoBook = child_process('rm', ['-r', './baker-master/books/a-study-in-scarlet']);
		if (code==0) { console.log('\x1b[32mCLONE BAKER SUCCEEDED WITHOUT ERRORS');}
		else { errorlog+='\x1b[31mCLONE BAKER ERROR\n' }
		gruntDev()
		});
	});
}


function jakeInstall() {
	console.log('\n\x1b[33mSTART JAKE INSTALL');
	var jakeInstall = child_process('jake', [], {cwd:'./bower_components/tinymce'});
	jakeInstall.stdout.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
	jakeInstall.stderr.on('data', function (data) { console.log("\x1b[31m", data.toString()); });
	jakeInstall.on('close', function (code) {
		if (code==0) { console.log('\x1b[32mJAKE INSTALL SUCCEEDED WITHOUT ERRORS');}
		else { errorlog+='\x1b[31mJAKE INSTALL ERROR\n' }
		bakermasterClone();
	});
}

function bowerInstall() {
	console.log('\n\x1b[33mSTART BOWER INSTALL');
	var bowerInstall = child_process('bower', ['install', '--allow-root']);
	bowerInstall.stdout.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
	bowerInstall.stderr.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
	bowerInstall.on('close', function (code) {
		if (code==0) { console.log('\x1b[32mBOWER INSTALL SUCCEEDED WITHOUT ERRORS');}
		else { errorlog+='\x1b[31mBOWER INSTALL ERROR\n' }
		jakeInstall();
	});
}

var npmInstall = child_process('npm', ['install']);
npmInstall.stdout.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
npmInstall.stderr.on('data', function (data) { console.log("\x1b[31m", data.toString()); });
npmInstall.on('close', function (code) {
	if (code==0) { console.log('\x1b[32mNPM INSTALL SUCCEEDED WITHOUT ERRORS'); }
	else { errorlog+='\x1b[31mNPM INSTALL ERROR\n' }
	bowerInstall();
});
