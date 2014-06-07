define([
    'cs!modules/settings/controller/SettingsController',
    'cs!modules/settings/model/Setting',
    'cs!modules/settings/model/Settings',
    'cs!modules/settings/view/SettingsLayout',
    'cs!modules/settings/view/SettingsListView',
], function(Controller, Model, Collection, Layout, ListView){

    describe('Testcases Setting Module', function() {

        it('new Model() is working', function() {
          expect(new Model()).toBeTruthy();
        });
        it('new Collection() is working', function() {
            expect(Collection).toBeTruthy();
        });
        it('new Controller() is working', function() {
            expect(new Controller()).toBeTruthy();
        });
        it('new Layout() is working', function() {
            expect(new Layout()).toBeTruthy();
        });
        it('new ListView() is working', function() {
            expect(new ListView()).toBeTruthy();
        });
    });

});