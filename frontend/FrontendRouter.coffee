define [
    'jquery',
    'lodash',
    'backbone',
    'cs!views/ListView',
    'cs!views/DetailView',
    'cs!models/Article',
    'cs!models/Articles'
],
( $, _, Backbone, ListView, DetailView, Article, Articles ) ->

	
  class FrontendRouter extends Backbone.Router
    initialize: ->
      @articles = new Articles()
      self = @		      
      @articles.fetch
        success: ->                   	                     	     	
          self.articleList();
        error: -> 
          console.log('fetch error')
  
    routes:
      "": "articleList",
      "article/:id": "details"

    details: (id) ->
      article = @articles.get(id)
      view = new DetailView model: article
      $('#list').html view.render()

    articleList: ->
       articleList = new ListView model: @articles
       $('#list').html articleList.addAll()