define ["lodash","backbone", "cs!./User"],
(_, Backbone, Model) ->

  class Users extends Backbone.Collection
    model: Model
    url: "/users/"