define ["lodash","backbone","localstorage", "cs!models/Article"], 
(_, Backbone, LocalStorage, Article) ->
  class Articles extends Backbone.Collection
    
    model: Article
    url: "/publicArticles/"