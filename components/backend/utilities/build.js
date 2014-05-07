var requirejs = require('requirejs');

var config = {

    appDir: '.',
    baseUrl: 'bower_components',

    //Uncomment to turn off uglify minification.
    //optimize: 'none',
    dir: './cache/build',

    //Stub out the cs module after a build since
    //it will not be needed.
    stubModules: ['cs'],

    paths: {
        'cs' :'require-cs/cs',
        'coffee-script': 'require-cs/coffee-script'
    },

    modules: [
        {
            name: '../components/backend/configuration/require-config',
            //The optimization will load CoffeeScript to convert
            //the CoffeeScript files to plain JS. Use the exclude
            //directive so that the coffee-script module is not included
            //in the built file.
            exclude: ['coffee-script', 'require-css/normalize']
        }
    ]
};

requirejs.optimize(config, function (buildResponse) {
    console.log("building success");
}, function(err) {
	console.log("error building", err);
    //optimization err callback
});


