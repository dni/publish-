require.config({
	deps: ["cs!/admin/App"],
	baseUrl: '/lib',
	paths: {
		jquery: "jquery/dist/jquery",
		"jquery.ui": "jquery-ui/ui/jquery-ui",
		"jquery.tinymce": "tinymce/js/tinymce/jquery.tinymce.min",
		tinymce: "tinymce/js/tinymce/tinymce",
		"jquery.form": "jquery-form/jquery.form",
		lodash: "underscore-amd/underscore",
		underscore: "underscore-amd/underscore",
		wreqr: "backbone.wreqr/lib/amd/backbone.wreqr",
		babysitter: "backbone.babysitter/lib/amd/backbone.babysitter",
		backbone: "backbone-amd/backbone",
		bootstrap: "bootstrap/dist/js/bootstrap",
		marionette: "marionette/lib/core/amd/backbone.marionette",
        localstorage: "backbone-localstorage/backbone-localstorage",
		text: 'requirejs-text/text',
		tpl: 'requirejs-tpl/tpl',
		cs: 'require-cs/cs',
		d3: 'd3/d3',
		gm: 'gm/index',
		minicolors: 'jquery-minicolors/jquery.minicolors'
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
		'jquery.tinymce':['jquery'],
		'jquery.form':['jquery'],
		'bootstrap':['jquery'],
		'minicolors':['jquery'],
	}
});
