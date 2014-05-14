require.config({
	// urlArgs: "bust=" + (new Date()).getTime(),
	deps: ['main'],
	//baseUrl: './',

	paths: {
		//utils: "utilities/Utilities",
		io: "vendor/socket.io",
		jquery: "vendor/jquery",
		"jquery.ui": "vendor/jquery-ui",
		tinymce: "vendor/tinymce",
		"jquery.form": "vendor/jquery.form",
		underscore: "vendor/underscore",
		wreqr: "vendor/backbone.wreqr",
		babysitter: "vendor/backbone.babysitter",
		backbone: "vendor/backbone",
		bootstrap: "vendor/bootstrap",
		marionette: "vendor/backbone.marionette",
        localstorage: "vendor/backbone-localstorage",
		less: 'vendor/require-less/less',
		text: 'vendor/requirejs-text/text',
		tpl: 'vendor/requirejs-tpl/tpl',
		cs: 'vendor/require-cs/cs',
		d3: 'vendor/d3',
		//gm: 'vendor/gm/index',
		minicolors: 'vendor/jquery.minicolors'
	},
	map: {
	    '*': {
	        'backbone.wreqr': 'wreqr',
	        'backbone.babysitter': 'babysitter',
	        'jquery.tinymce': 'tinymce'
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
	    main: 'vendor/require-cs/cs'
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
