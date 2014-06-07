define([
    'cs!modules/files/FileModule',
    'cs!modules/files/controller/FileController',
    'cs!modules/files/model/File',
    'cs!modules/files/model/Files',
    'cs!modules/files/view/DetailView',
    'cs!modules/files/view/ListView',
], function(Module, Controller, Model, Collection, DetailView, ListView){

    describe('Testcases File Module', function() {

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
    });

});