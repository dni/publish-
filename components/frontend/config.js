require.config({
	deps: ["main"],
	paths: {
		jquery: "vendor/jquery",
		fancybox: "vendor/fancybox/jquery.fancybox",
		lodash: "vendor/underscore",
		backbone: "vendor/backbone",
		marionette: "vendor/marionette",
		babysitter: "vendor/babysitter",
		wreqr: "vendor/wreqr",
		text: 'vendor/text',
		cs: 'vendor/cs',
		tpl: 'vendor/tpl',
		underscore: 'vendor/underscore'
	},
	packages: [
      {
        name: 'less',
        location: 'vendor/require-less',
        main: 'less'
      },{
	    name: 'cs',
	    location: 'vendor',
	    main: 'cs'
	  },{
	    name: 'coffee-script',
	  	location: 'vendor',
	    main: 'coffee-script'
	  },{
	    name: 'i18n',
	  	location: 'vendor/require-i18n',
	    main: 'i18n'
	  }
    ],
	// map: {
	    // '*': {
	        // 'jquery.fancybox': 'fancybox'
	    // }
	// },
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
