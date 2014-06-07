define([
    'cs!modules/messages/controller/Controller',
    'cs!modules/messages/model/Model',
    'cs!modules/messages/model/Collection',
    'cs!modules/messages/view/MessageDetailView',
    'cs!modules/messages/view/MessageListView',
], function(Controller, Model, Collection, DetailView, ListView){

    describe('Testcases Message Module', function() {

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