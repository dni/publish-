var requirejs = require('requirejs');

var config = {
  appDir: "components/backend",
  dir: "cache/build/backend",
  mainConfigFile: 'components/backend/config.js',
  // out: "cache/main.built.js",
  // include : 'main.js',

  // optimize: "uglify",
//
  // uglify: {
    // toplevel: true,
    // ascii_only: true,
    // beautify: false,
    // max_line_length: 1000
  // },

  inlineText: true,
  useStrict: false,

  skipPragmas: false,
  skipModuleInsertion: false,
  stubModules: ['text', 'cs', 'less'],
  optimizeAllPluginResources: false,
  findNestedDependencies: false,
  removeCombined: false,

  fileExclusionRegExp: /^\./,

  preserveLicenseComments: true,

  logLevel: 0
}


requirejs.optimize(config, function (buildResponse) {
    console.log("building success");
}, function(err) {
	console.log("error building", err);
    //optimization err callback
});


