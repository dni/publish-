require.config({
	// urlArgs: "bust=" + (new Date()).getTime(),
	deps: ['main'],
	//baseUrl: './',

	paths: {
		App: "utilities/App",
		Router: "utilities/Router",
		utils: "utilities/Utilities",
		io: "vendor/io",
		jquery: "vendor/jquery",
		"jquery.ui": "vendor/jquery.ui",
		tinymce: "vendor/tinymce",
		"jquery.form": "vendor/jquery.form",
		underscore: "vendor/underscore",
		wreqr: "vendor/wreqr",
		babysitter: "vendor/babysitter",
		backbone: "vendor/backbone",
		bootstrap: "vendor/bootstrap",
		marionette: "vendor/marionette",
        localstorage: "vendor/backbone-localstorage",
		less: 'vendor/require-less/less',
		text: 'vendor/require-text/text',
		tpl: 'vendor/require-tpl/tpl',
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
	shim: {
		'jquery.ui':['jquery'],
		'jquery.tinymce':['jquery'],
		'jquery.form':['jquery'],
		'bootstrap':['jquery'],
		'minicolors':['jquery'],
	}
});
