define ['jquery', 'lodash', 'backbone', 'tpl!../templates/listItem.html', 'tpl!../templates/list.html', 'tpl!../templates/filter.html'], 
($, _, Backbone, Template, ListTemplate, FilterTemplate) ->

  class ArticleListItemView extends Backbone.Marionette.ItemView 
    template: Template
    onRender: ->
      console.log "lol"
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
    itemView: ArticleListItemView
    