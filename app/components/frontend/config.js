require.config({
	deps: ["cs!/app/modules/App"],
	paths: {
		jquery: "/lib/jquery-1.8.3.min",
		lodash: "/lib/lodash.min",
		backbone: "/lib/backbone",
        localstorage: "/lib/backbone-localstorage",
		text: '/lib/text',
		cs: '/lib/cs',
		fancybox: '/lib/jquery.fancybox.pack',
		underscore: '/lib/underscore',
		collapse: '/lib/bootstrap-collapse'
	}, 
	shim: {
		backbone: {
			deps: ["lodash", "jquery"],
			exports: "Backbone"
		},
		'jquery.collapse': ['jquery'],
		'backbone.localstorage': ['backbone'],
	}
});
