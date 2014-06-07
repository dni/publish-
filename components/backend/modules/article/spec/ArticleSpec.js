define([
    'cs!modules/article/controller/ArticleController',
    'cs!modules/article/model/Article',
    'cs!modules/article/model/Articles',
    'cs!moduleS/article/view/ArticleDetailView',
    'cs!moduleS/article/view/ArticleListView',
    'cs!moduleS/article/view/ArticleLayout'
], function( Controller, Model, Collection, DetailView, ListView, Layout){

    describe('Testcases Article Module', function() {

        it('new Model() is working', function() {
          expect(new Model()).toBeTruthy();
        });
        it('new Collection() is working', function() {
            expect(new Collection()).toBeTruthy();
        });
        it('new Controller() is working', function() {
            expect(new Controller()).toBeTruthy();
        });
        it('new DetailView() is working', function() {
            expect(new DetailView()).toBeTruthy();
        });
        it('new ListView() is working', function() {
            expect(new ListView()).toBeTruthy();
        });
        it('new Layout() is working', function() {
            expect(new Layout()).toBeTruthy();
        });
    });

});