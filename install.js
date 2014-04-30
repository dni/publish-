var child_process = require('child_process').spawn;
console.log('\x1b[33mPUBLISH! INSTALLATION STARTED');
console.log('\x1b[33mSTART NPM INSTALL');

function bakermasterClone() {
	console.log('\x1b[33mSTART CLONE BAKER');
	var rmBakerDir = child_process('rm', ['-r', 'baker-master']);
	rmBakerDir.on('exit', function (code) {
		var bakermasterClone = child_process('git', ['clone', 'https://github.com/bakerframework/baker.git', 'baker-master']);
		console.log("\x1b[36m")
		bakermasterClone.stdout.on('data', function (data) { console.log(data.toString()); });
		bakermasterClone.stderr.on('data', function (data) { console.log(data.toString()); });
		bakermasterClone.on('close', function (code) {
		var rmDemoBook = child_process('rm', ['-r', './baker-master/books/a-study-in-scarlet']);
		if (code==0) { console.log('\x1b[32mCLONE BAKER SUCCEEDED WITHOUT ERRORS');}
		else { console.log('\x1b[31mCLONE BAKER ERROR') }
		console.log('\x1b[32m\x1b[5mINSTALLATION IS COMPLETE !!!');
		console.log("\x1b[47m\x1b[30m");
		});
	});
}

function jakeInstall() {
	console.log('\x1b[33mSTART JAKE INSTALL');
	var jakeInstall = child_process('jake', [], {cwd:'./bower_components/tinymce'});
	jakeInstall.stdout.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
	jakeInstall.stderr.on('data', function (data) { console.log("\x1b[31m", data.toString()); });
	jakeInstall.on('close', function (code) {
		if (code==0) { console.log('\x1b[32mJAKE INSTALL SUCCEEDED WITHOUT ERRORS');}
		else { console.log('\x1b[31mJAKE INSTALL ERROR') }
		bakermasterClone();
	});
}

function bowerInstall() {
	console.log('\x1b[33mSTART BOWER INSTALL');
	var bowerInstall = child_process('bower', ['install', '--allow-root']);
	bowerInstall.stdout.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
	bowerInstall.stderr.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
	bowerInstall.on('close', function (code) {
		if (code==0) { console.log('\x1b[32mBOWER INSTALL SUCCEEDED WITHOUT ERRORS');}
		else { console.log('\x1b[31mBOWER INSTALL ERROR') }
		jakeInstall();
	});
}

var npmInstall = child_process('npm', ['install']);
npmInstall.stdout.on('data', function (data) { console.log("\x1b[36m", data.toString()); });
npmInstall.stderr.on('data', function (data) { console.log("\x1b[31m", data.toString()); });
npmInstall.on('close', function (code) {
	if (code==0) { console.log('\x1b[32mNPM INSTALL SUCCEEDED WITHOUT ERRORS'); }
	else { console.log('\x1b[31mNPM INSTALL ERROR') }
	bowerInstall();
});
