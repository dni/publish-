require.config({
	// urlArgs: "bust=" + (new Date()).getTime(),
	deps: ['main'],
	paths: {
		App: "utilities/App",
		Router: "utilities/Router",
		utils: "utilities/Utilities",
		io: "vendor/socket.io-client/dist/socket.io",
		jquery: "vendor/jquery/dist/jquery",
		"jquery.ui": "vendor/jquery-ui/ui/jquery-ui",
		"jquery.tinymce": "vendor/tinymce/js/tinymce/jquery.tinymce.min",
		tinymce: "vendor/tinymce/js/tinymce/tinymce",
		"jquery.form": "vendor/jquery-form/jquery.form",
		underscore: "vendor/underscore-amd/underscore",
		wreqr: "vendor/backbone.wreqr/lib/amd/backbone.wreqr",
		babysitter: "vendor/backbone.babysitter/lib/backbone.babysitter",
		backbone: "vendor/backbone-amd/backbone",
		bootstrap: "vendor/bootstrap/dist/js/bootstrap",
		marionette: "vendor/marionette/lib/core/amd/backbone.marionette",
        localstorage: "vendor/backbone-localstorage/backbone-localstorage",
		text: 'vendor/requirejs-text/text',
		tpl: 'vendor/requirejs-tpl/tpl',
		cs: 'vendor/require-cs/cs',
		d3: 'vendor/d3/d3',
		gm: 'vendor/gm/index',
		minicolors: 'vendor/jquery-minicolors/jquery.minicolors'
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
        location: 'vendor/require-less',
        main: 'less'
      },{
	    name: 'cs',
	    location: 'vendor/require-cs',
	    main: 'cs'
	  },{
	    name: 'coffee-script',
	  	location: 'vendor/coffee-script',
	    main: 'index'
	  },{
	    name: 'i18n',
	  	location: 'vendor/requirejs-i18n',
	    main: 'i18n'
	  }
    ],
	shim: {
		'jquery.ui':['jquery'],
		'jquery.tinymce':['jquery'],
		'jquery.form':['jquery'],
		'bootstrap':['jquery'],
		'minicolors':['jquery'],
	}
});
