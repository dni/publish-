define [
  "lodash"
  "backbone"
  "cs!./StaticBlock"
], (_, Backbone, Model) ->

  class StaticBlocks extends Backbone.Collection
    model: Model
    url: "/blocks/"