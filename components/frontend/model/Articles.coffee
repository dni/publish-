define ["lodash","backbone", "cs!model/Article"],
(_, Backbone, Article) ->
  class Articles extends Backbone.Collection

    model: Article
    url: "/publicarticles/"