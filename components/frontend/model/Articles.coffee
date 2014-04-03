define ["lodash","backbone", "cs!./Article"],
(_, Backbone, Article) ->
  class Articles extends Backbone.Collection

    model: Article
    url: "/publicarticles/"