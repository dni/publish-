require.config({
	deps: ["cs!/App"],
	baseUrl: '/lib',
	paths: {
		jquery: "jquery/dist/jquery",
		fancybox: "fancybox/source/jquery.fancybox",
		lodash: "underscore-amd/underscore",
		backbone: "backbone-amd/backbone",
		marionette: "marionette/lib/core/amd/backbone.marionette",
		babysitter: "backbone.babysitter/lib/backbone.babysitter",
		wreqr: "backbone.wreqr/lib/amd/backbone.wreqr",
		text: 'requirejs-text/text',
		cs: 'require-cs/cs',
		text: 'requirejs-text/text',
		tpl: 'requirejs-tpl/tpl',
		cs: 'require-cs/cs',
		underscore: 'underscore-amd/underscore'
	},
	packages: [
      {
        name: 'less',
        location: 'require-less',
        main: 'less'
      },{
	    name: 'cs',
	    location: 'require-cs',
	    main: 'cs'
	  },{
	  	location: 'coffee-script',
	    name: 'coffee-script',
	    main: 'index'
	  }
    ],

    shim: {
		'jquery.fancybox':['jquery']
	},

    map: {
        "*": {
            "backbone.wreqr": "wreqr",
            "backbone.babysitter": "babysitter"
        }
    },

});
