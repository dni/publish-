var requirejs = require('requirejs');

var config = {
  appDir: "components/backend",
  dir: "cache/build/backend",
  baseUrl: "../../../bower_components",
  mainConfigFile: 'components/backend/configuration/require-config.js',
  // out: "cache/main.built.js",
  include : 'require-config',

  optimize: "uglify",

  uglify: {
    toplevel: true,
    ascii_only: true,
    beautify: false,
    max_line_length: 1000
  },

  inlineText: true,
  useStrict: false,

  skipPragmas: false,
  skipModuleInsertion: false,
  stubModules: ['text'],
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


