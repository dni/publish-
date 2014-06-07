define([
    'cs!modules/user/controller/UserController',
    'cs!modules/user/model/User',
    'cs!modules/user/model/Users',
    'cs!modules/user/view/UserDetailView',
    'cs!modules/user/view/UserListView',
], function(Controller, Model, Collection, DetailView, ListView){

    describe('Testcases User Module', function() {

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