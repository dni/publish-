define([
    'cs!modules/static/controller/StaticBlockController',
    'cs!modules/static/model/StaticBlock',
    'cs!modules/static/model/StaticBlocks',
    'cs!modules/static/view/DetailView',
    'cs!modules/static/view/ListView',
], function(Controller, Model, Collection, DetailView, ListView){

    describe('Testcases Static Block Module', function() {

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
    });

});