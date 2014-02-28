define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Setting extends Backbone.Model
    defaults:
      "title": "Neuer Setting"