define [
  'backbone'
], (Backbone) ->
  class StaticBlock extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "staticBlocks"
    defaults:
      "key": ""
      "data": ""
      "deleteable": true




