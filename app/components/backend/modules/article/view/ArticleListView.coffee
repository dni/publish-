define ['jquery', 'lodash', 'backbone', 'tpl!../templates/listItem.html', 'tpl!../templates/filter.html'], 
($, _, Backbone, Template, FilterTemplate) ->


  class ArticleListItemView extends Backbone.Marionette.ItemView 
    template: Template
    # initialize: ->
      # @model.bind "change", @render, @
      # @model.bind "destroy", @close, @
# 
#       
  # class FilterView extends Backbone.View  
    # tagName: 'fieldset'   
    # initialize: ->
      # @template = FilterTemplate
    # render: ->    
      # @$el.html @template()
      # @el
    # events:
      # "click #add": "addAction"
    # addAction: ->
      # if $("#showArticles").parent().hasClass("active") then App.navigate "article/new", true else App.navigate "magazine/new", true
      # return false

   
   
  class ArticleListView extends Backbone.Marionette.CollectionView
    itemView: new ArticleListItemView
       