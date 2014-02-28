define ["lodash","backbone", "cs!models/Article"], 
(_, Backbone, Article) ->
  class Articles extends Backbone.Collection
    
    model: Article
    url: "/publicArticles/"