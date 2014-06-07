define([
    'cs!App',
    'cs!modules/article/ArticleModule',
    'cs!utils',
    'cs!Router',
    'cs!modules/article/controller/ArticleController',
    'cs!modules/article/model/Article',
    'cs!modules/article/model/Articles',
    'cs!modules/article/view/ArticleDetailView',
    'cs!modules/article/view/ArticleListView',
    'cs!modules/article/view/ArticleLayout'
], function(App, Module, Utils, Router, Controller, Model, Collection, DetailView, ListView, Layout){

    describe('Testcases Article Module', function() {

        // jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000;


        it('List Route is working', function() {
          Router.navigate("articles", {trigger:true});
          expect(App.listRegion.currentView.constructor.name === "ArticleListView").toBeTruthy();
        });
    });

});