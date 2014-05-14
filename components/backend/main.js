define([
	"backbone",
	"cs!App",
	"less!modules/publish/style/main",
	"cs!modules/publish/Regions",
	"cs!modules/publish/Events",
	"cs!modules/publish/Socket",
	"cs!modules/settings/SettingsModule",
	"cs!modules/files/FileModule",
	// "cs!modules/user/UserModule",
	"cs!modules/publish/PublishModule",
	"cs!modules/article/ArticleModule",
	// "cs!modules/magazine/MagazineModule",
	// "cs!modules/baker/BakerModule",
	// "cs!modules/static/StaticModule",
    // "cs!modules/messages/MessageModule",
	// coming soon in 2.0
	// "cs!modules/reports/ReportModule",
], function(Backbone){
    Backbone.history.start();
});
