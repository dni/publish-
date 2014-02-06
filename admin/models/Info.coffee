define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Info extends Backbone.Model
    defaults:
      "type": null ## types == download / messageOnly
      "message": ""
      "messageType": "" ## msgtypes == success / info / warning / danger
