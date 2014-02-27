define ["lodash","backbone", "cs!./Magazine"],
(_, Backbone, Model) ->

  class Magazines extends Backbone.Collection
    model: Model
    url: "/magazines/"