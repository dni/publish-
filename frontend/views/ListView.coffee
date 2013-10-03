define ['jquery', 'lodash', 'backbone', 'text!templates/listItem.html'], 
($, _, Backbone, Template) ->
 
  class ListItemView extends Backbone.View  
    tagName: "li"    
    initialize: ->
      @template = _.template Template  
      @model.bind "change", @render, @
      @model.bind "destroy", @close, @      
    render: ->  
      @$el.html @template @model.toJSON()     
      @el
            
  class ListView extends Backbone.View   
    tagName: 'ul'   
    initialize: ->
      @model.bind "reset", @addAll, @
      @model.bind "add", @addOne, @
    addAll: ->  
      _.each  @model.models, 
        (article) -> 
          @addOne(article)
        @
      @el
    addOne: (article) ->
      view = new ListItemView model: article
      @$el.append view.render()  
      @el