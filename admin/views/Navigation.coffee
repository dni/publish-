define ['jquery', 'fancybox', 'lodash', 'backbone', 'cs!views/ListView', 'text!templates/navigation.html'],
($, fancybox, _, Backbone, listView, Template) ->
  
  class Navigation extends Backbone.View
    initialize: ->
      @template = _.template Template
    
    render: ->
      @$el.html @template categories:@categories
      return @el
    
    events:
      "keyup input": "search"
      "click #showArticles": "showArticles"
      "click #showMagazines": "showMagazines"
      "click #login": "loginView"
    
    search: ->
      if this.$el.length > 3
        term = this.$el.val()
        $.get '/codes/search/?term='+term, (data) ->
          view = new ListView model:data
          view.render()
    
    activate: (evt)->

      el = $(evt.target)
      if el.hasClass('active') 
        false

      @$el.find('.active').removeClass('active')
      el.parent().addClass('active')
      $('.list').hide()
      $(el.attr('href')).show()
      true

    showArticles: (evt)->
      if @activate evt then app.navigate "/articles", trigger: true
      
    showMagazines: (evt)->
      if @activate evt then app.navigate "/magazines", trigger: true
  
    addCode: ->
      app.navigate "article/new", true
      return false
    
    loginView: ->
      $.fancybox $('#login div').html()
      return false
      

