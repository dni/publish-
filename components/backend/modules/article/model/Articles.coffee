define ["lodash","backbone","localstorage", "cs!./Article"], 
(_, Backbone, LocalStorage, Model) ->
  class Articles extends Backbone.Collection   
    model: Model
    url: "/articles/"