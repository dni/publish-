var child_process = require('child_process').spawn;

function bakermasterClone() {
	var rmBakerDir = child_process('rm', ['-r', 'baker-master']);
	rmBakerDir.on('exit', function (code) {
		var bakermasterClone = child_process('git', ['clone', 'https://github.com/bakerframework/baker.git', 'baker-master']);
		bakermasterClone.stdout.on('data', function (data) { console.log(data.toString()); });
		bakermasterClone.stderr.on('data', function (data) { console.log(data.toString()); });
		bakermasterClone.on('close', function (code) {
			var rmDemoBook = child_process('rm', ['-r', './baker-master/books/a-study-in-scarlet']);
			console.log('bakermasterClone exited with code ' + code);
			console.log('Installation is complete');
		});
	});
}

function jakeInstall() {
	var jakeInstall = child_process('jake', [], {cwd:'./bower_components/tinymce'});
	jakeInstall.stdout.on('data', function (data) { console.log(data.toString()); });
	jakeInstall.stderr.on('data', function (data) { console.log(data.toString()); });
	jakeInstall.on('close', function (code) {
		console.log('jakeInstall exited with code ' + code);
		bakermasterClone();
	});
}

function bowerInstall() {
	var bowerInstall = child_process('bower', ['install', '--allow-root']);
	bowerInstall.stdout.on('data', function (data) { console.log(data.toString()); });
	bowerInstall.stderr.on('data', function (data) { console.log(data.toString()); });
	bowerInstall.on('close', function (code) {
		console.log('bowerInstall exited with code ' + code);
		jakeInstall();
	});
}

var npmInstall = child_process('npm', ['install']);
npmInstall.stdout.on('data', function (data) { console.log(data.toString()); });
npmInstall.stderr.on('data', function (data) { console.log(data.toString()); });
npmInstall.on('close', function (code) {
	console.log('npmInstall exited with code ' + code);
	bowerInstall();
});
