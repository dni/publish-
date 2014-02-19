define ["lodash","backbone","localstorage", "cs!models/Magazine"], 
(_, Backbone, LocalStorage, Magazine) ->
  class Magazines extends Backbone.Collection
    
    model: Magazine
    url: "/magazines/"