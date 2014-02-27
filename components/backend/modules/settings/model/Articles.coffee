define ["lodash","backbone", "cs!./Article"], 
(_, Backbone, Model) ->
  
  class Articles extends Backbone.Collection   
    model: Model
    url: "/articles/"