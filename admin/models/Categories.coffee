define ["lodash","backbone","localstorage", "cs!models/Category"], 
(_, Backbone, LocalStorage, Category) ->
  class Categories extends Backbone.Collection
    model: Category
    localStorage: new Backbone.LocalStorage "categories"
