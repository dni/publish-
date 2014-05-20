define ["backbone", "cs!./User"],
(Backbone, Model) ->

  class Users extends Backbone.Collection
    model: Model
    url: "/users/"