define ['jquery', 'lodash', 'backbone', 'text!templates/listItem.html','text!templates/listMagItem.html', 'text!templates/filter.html'], 
($, _, Backbone, Template, MagTemplate, FilterTemplate) ->

 
  class ArticleListItemView extends Backbone.Marionette.ItemView 
    template: -> _.template Template
    initialize: ->
      if $("#showArticles").parent().hasClass("active") then @template =  else  @template = _.template MagTemplate
      @model.bind "change", @render, @
      @model.bind "destroy", @close, @      
    render: ->  
      @$el.html @template @model.toJSON()     
      @el

      
  class FilterView extends Backbone.View  
    tagName: 'fieldset'   
    initialize: ->
      @template = _.template FilterTemplate
    render: ->    
      @$el.html @template()
      @el
    events:
      "click #add": "addAction"
    addAction: ->
      if $("#showArticles").parent().hasClass("active") then App.navigate "article/new", true else App.navigate "magazine/new", true
      return false

   
   
  class ArticleListView extends Backbone.Marionette.CollectionView
    itemView: new ListItemView
       
  class ListView extends Backbone.View   
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