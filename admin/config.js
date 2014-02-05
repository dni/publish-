require.config({
	deps: ["cs!/lib/backend"],
	paths: {
		jquery: "/lib/jquery-1.8.3.min",
		lodash: "/lib/lodash.min",
		backbone: "/lib/backbone",
		marionette: "/lib/backbone.marionette",
        localstorage: "/lib/backbone-localstorage",
		text: '/lib/text',
		cs: '/lib/cs',
		fancybox: '/lib/jquery.fancybox.pack',
		underscore: '/lib/underscore',
		collapse: '/lib/bootstrap-collapse',
		fileupload: '/lib/jquery.fileupload'

	},
	shim: {
		backbone: {
			deps: ["lodash", "jquery"],
			exports: "Backbone"
		},
		'jquery.fileupload':['jquery'],
		'jquery.fancybox': ['jquery'],
		'jquery.collapse': ['jquery'],

		'backbone.localstorage': ['backbone'],
		"marionette":{
            "deps":["lodash", "backbone", "jquery"],
            "exports":"Marionette"
        },
	}
});
