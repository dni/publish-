define ['jquery', 'lodash', 'backbone', 'text!templates/pageListItem.html'], 
($, _, Backbone, Template) ->
 
  class PageListItemView extends Backbone.View  
    tagName: "li"    
    initialize: ->
      @template = _.template Template
      @model.bind "change", @render, @
      @model.bind "destroy", @close, @  
      
    events:
      "click .remove": "deletePage"
      "change select": "updatePage"
      
    updatePage: ->
      @model.set
        "number": @$el.find(".number").text()
        "layout": @$el.find(".layout").val()
        "article": @$el.find(".article").val()
      @model.save
      
    deletePage: ->
      @model.destroy
        success: ->
      
    render: ->  
      @$el.html @template 
        model: @model.toJSON()    
        articles: app.articles.toJSON() 
      @el
            
  class PageListView extends Backbone.View   
    tagName: 'ul'   
    initialize: ->
      @model.bind "reset", @addAll, @
      @model.bind "add", @addOne, @
    addAll: ->  
      _.each  @model.models, 
        (model) -> 
          @addOne(model)
        @
      @el
    addOne: (model) ->
      view = new PageListItemView model: model
      @$el.append view.render()  
      @el