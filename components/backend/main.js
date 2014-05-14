define([
	"cs!modules/publish/App",
	'backbone',
	"cs!modules/article/ArticleModule",
	// "cs!./modules/magazine/MagazineModule",
	// "cs!./modules/baker/BakerModule",
	// "cs!./modules/settings/SettingsModule",
	// "cs!./modules/files/FileModule",
	// "cs!./modules/static/StaticModule",
    // "cs!modules/messages/MessageModule",
	// // coming soon in 2.0
	// // "cs!modules/reports/ReportModule",
	// "cs!./modules/user/UserModule"
], function(App, Backbone, Article){
	console.log("done loading modules", Article);
	App.start();
    window.App = App
    Backbone.history.start()
});
