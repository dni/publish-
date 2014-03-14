require.config({
	deps: ["cs!./App"],
	paths: {
		jquery: "/lib/jquery/dist/jquery",
		lodash: "/lib/lodash-amd/main",
		backbone: "/lib/backbone-amd/backbone",
		marionette: "/lib/marionette/lib/core/amd/backbone.marionette",
		wreqr: "/lib/backbone.babysitter/lib/amd/backbone.babysitter",
		babysitter: "/lib/backbone.wreqr/lib/amd/backbone.wreqr",
		text: '/lib/requirejs-text/text',
		cs: '/lib/require-cs/cs',
		text: '/lib/requirejs-text/text',
		tpl: '/lib/requirejs-tpl/tpl',
		cs: '/lib/require-cs/cs',
		underscore: '/lib/underscore-amd/underscore'
	},
	packages: [
      {
        name: 'less',
        location: '/lib/require-less',
        main: 'less'
      },{
	    name: 'cs',
	    location: '/lib/require-cs',
	    main: 'cs'
	  },{
	  	location: '/lib/coffee-script',
	    name: 'coffee-script',
	    main: 'index'
	  }
    ],

    map: {
        "*": {
            "backbone.wreqr": "wreqr",
            "backbone.babysitter": "babysitter"
        }
    },

});
