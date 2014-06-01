define(['backbone', 'cs!modules/article/model/Article'], function(Backbone, Article){

    describe('Testcases Article Module', function() {
        var article;

        beforeEach(function(){
            article = new Article();
        });

        it('should be an instance of Backbone.Model', function() {
            expect(article instanceof Backbone.Model).toBeTruthy();
        });
    });

});