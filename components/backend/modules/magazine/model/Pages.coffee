define ["lodash","backbone","localstorage", "cs!models/Page"], 
(_, Backbone, LocalStorage, Page) ->
  class Pages extends Backbone.Collection
    model: Pages
