define ['jquery', 'lodash', 'backbone','text!templates/infoItem.html'],
($, _, Backbone, Template, MagTemplate, FilterTemplate) ->

  class InfoItemView extends Backbone.View
    tagName: "li"
    initialize: ->
      #if $("#showArticles").parent().hasClass("active") then @template = _.template Template else  @template = _.template MagTemplate
      @model.bind "change", @render, @
      @model.bind "destroy", @close, @

    render: ->
      @$el.html @template @model.toJSON()
      @el


  class InfoView extends Backbone.View
    tagName: 'ul'
    initialize: ->
      @model.bind "reset", @addAll, @
      @model.bind "add", @addOne, @
    addAll: ->
      view = new FilterView
      @$el.prepend view.render()
      _.each  @model.models,
        (model) ->
          @addOne(model)
        @
      @el
    addOne: (model) ->
      view = new ListItemView model: model
      @$el.append view.render()
      @el