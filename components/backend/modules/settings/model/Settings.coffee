define ["lodash","backbone", "cs!./Setting"], 
(_, Backbone, Model) ->
  
  class Settings extends Backbone.Collection   
    model: Model
    # url:"/settings/"
