define [
  "backbone"
  "cs!./StaticBlock"
], (Backbone, Model) ->

  class StaticBlocks extends Backbone.Collection
    model: Model
    url: "/staticBlocks/"