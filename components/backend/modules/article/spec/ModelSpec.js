define(['backbone', 'cs!modules/article/model/Article'], function(Backbone, Article){

    describe('Testcases Article Model', function() {
        var controller;

        beforeEach(function(){
            article = new Article();
        });

        it('should be published after calling togglePublish', function() {
        	article.togglePublish();
            expect(article.get('published')).toBeTruthy();
        });

    });

});