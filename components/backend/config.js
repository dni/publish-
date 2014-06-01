require.config({
    baseUrl: 'components/backend/',
	paths: {
		App: "utilities/App",
		Router: "utilities/Router",
		utils: "utilities/Utilities",
		io: "vendor/io",
		jquery: "vendor/jquery",
		"jquery.ui": "vendor/jquery.ui",
		tinymce: "vendor/tinymce/tinymce.min",
		"jquery.tinymce": "vendor/jquery.tinymce",
		"jquery.form": "vendor/jquery.form",
		underscore: "vendor/underscore",
		wreqr: "vendor/wreqr",
		babysitter: "vendor/babysitter",
		backbone: "vendor/backbone",
		bootstrap: "vendor/bootstrap/dist/js/bootstrap",
		marionette: "vendor/marionette",
        localstorage: "vendor/backbone-localstorage",
		less: 'vendor/require-less/less',
		text: 'vendor/text',
		tpl: 'vendor/tpl',
		cs: 'vendor/cs',
		css: 'vendor/css',
		d3: 'vendor/d3',
		//gm: 'vendor/gm/index',
		minicolors: 'vendor/minicolors/jquery.minicolors'
	},
	map: {
	    '*': {
	        'backbone.wreqr': 'wreqr',
	        'backbone.babysitter': 'babysitter',
	    }
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
	    name: 'css',
	    location: 'vendor/css',
	    main: 'css'
	  },{
	    name: 'coffee-script',
	  	location: 'vendor',
	    main: 'coffee-script'
	  },{
	    name: 'i18n',
	  	location: 'vendor',
	    main: 'i18n'
	  }
    ],
	shim: {
		'jquery.ui':['jquery'],
		'jquery.tinymce':['jquery', 'tinymce'],
		'jquery.form':['jquery'],
		'bootstrap':['jquery'],
		'minicolors':['jquery'],
	}
});

require(['main']);
