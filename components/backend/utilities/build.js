var requirejs = require('requirejs');

// var config = {
  // appDir: "components/backend",
  // dir: "cache/build/backend",
  // baseUrl: "bower_components",
  // mainConfigFile: 'components/backend/configuration/require-config.js',
  // // out: "cache/main.built.js",
  // include : 'App',
//
  // optimize: "uglify",
//
  // uglify: {
    // toplevel: true,
    // ascii_only: true,
    // beautify: false,
    // max_line_length: 1000
  // },
//
  // inlineText: true,
  // useStrict: false,
//
  // skipPragmas: false,
  // skipModuleInsertion: false,
  // stubModules: ['text'],
  // optimizeAllPluginResources: false,
  // findNestedDependencies: false,
  // removeCombined: false,
//
  // fileExclusionRegExp: /^\./,
//
  // preserveLicenseComments: true,
//
  // logLevel: 0
// }
var config = {
	appDir: "../",
	//- this is the directory that the new files will be. it will be created if it doesn't exist
	dir: "../../cache/build/backend",
	optimizeCss: "standard.keepLines",
	modules: [
		{
			name: "App"
		}
	],
	fileExclusionRegExp: /\.git/
};

requirejs.optimize(config, function (buildResponse) {
    console.log("building success");
}, function(err) {
	console.log("error building", err);
    //optimization err callback
});


