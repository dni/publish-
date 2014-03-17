require.config({
	deps: ["cs!/admin/App"],
	baseUrl: '/admin/lib',
	paths: {
		jquery: "jquery/dist/jquery",
		"jquery.ui": "jquery-ui/ui/jquery-ui",
		"jquery.form": "jquery-form/jquery.form",
		lodash: "lodash-amd/main",
		underscore: "underscore-amd/underscore",
		wreqr: "backbone.wreqr/lib/amd/backbone.wreqr",
		babysitter: "backbone.babysitter/lib/amd/backbone.babysitter",
		backbone: "backbone-amd/backbone",
		marionette: "marionette/lib/core/amd/backbone.marionette",
        localstorage: "backbone-localstorage/backbone-localstorage",
		text: 'requirejs-text/text',
		tpl: 'requirejs-tpl/tpl',
		cs: 'require-cs/cs',
	},
	map: {
	    '*': {
	        'backbone.wreqr': 'wreqr',
	        'backbone.babysitter': 'babysitter'
	    }
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
		'jquery.ui':['jquery'],
		'jquery.form':['jquery'],
	}
});
