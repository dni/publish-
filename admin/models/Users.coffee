define ["lodash","backbone","localstorage", "cs!models/User"], 
(_, Backbone, LocalStorage, Model) ->
  class Users extends Backbone.Collection
    
    model: Model
 #   localStorage: new Backbone.LocalStorage "users"
 #   url: "http://178.191.5.189:8080/codes/"
