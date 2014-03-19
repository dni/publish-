define [
  'jquery',
  'lodash',
  'backbone',
  'tpl!../templates/detail.html',
], ($, _, Backbone, Template) ->

  class ArticleDetailView extends Backbone.Marionette.ItemView

    template: Template

