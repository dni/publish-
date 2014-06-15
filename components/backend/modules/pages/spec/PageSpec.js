define([
    'cs!modules/pages/controller/PageController',
    'cs!modules/pages/model/Page',
    'cs!modules/pages/model/Pages',
    'cs!modules/pages/view/PageDetailView',
    'cs!modules/pages/view/PageListView',
    'cs!modules/pages/view/PageMagazineListView',
], function( Controller, Model, Collection, DetailView, ListView, PageView){

    describe('Testcases Pages Module', function() {

        it('new Model() is working', function() {
          expect(new Model()).toBeTruthy();
        });
        it('new Collection() is working', function() {
            expect(new Collection()).toBeTruthy();
        });
        it('new Controller() is working', function() {
            expect(new Controller()).toBeTruthy();
        });
        it('new ListView() is working', function() {
            expect(new ListView()).toBeTruthy();
        });
        it('new PageMagazineListView() is working', function() {
            expect(new PageView()).toBeTruthy();
        });
    });

});