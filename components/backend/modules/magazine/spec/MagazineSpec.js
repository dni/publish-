define(['backbone', 'cs!modules/magazine/model/Magazine'], function(Backbone, Article){

    describe('Testcases Magazine Module', function() {
        var article;

        beforeEach(function(){
            article = new Article();
        });

        it('should be an instance of Backbone.Model', function() {
            expect(article instanceof Backbone.Model).toBeTruthy();
        });
    });

});