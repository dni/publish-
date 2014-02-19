define ["lodash","backbone", "cs!./NavItem"], (_, Backbone, Model) ->
  class NavItems extends Backbone.Collection
    model: Model