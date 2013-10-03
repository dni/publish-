define ['jquery', 'lodash', 'backbone', 'text!templates/detail.html'], ( $, _, Backbone, Template) -> 
	
  class DetailView extends Backbone.View
    # Not required since 'div' is the default if no el or tagName specified
    initialize: ->
      @template = _.template Template
      @model.bind "change", this.render, this 

    render: (eventName) ->
      @$el.html @template
        model:@model.toJSON()
        
      @$el.find("output img").dblclick ()-> 
        $(@).remove()
        console.log "click"
      @el
        
    events: 
      "click #edit": "toggleEdit"
      "click .save": "saveArticle"
      "click .delete": "deleteArticle"
      'click #publish': "publishArticle"
        
    toggleEdit: ->
      @$el.find('.edit').toggle();
      @$el.find('.preview').toggle();
      @$el.find('.saved').toggle();	
        
    publishArticle: ->
      @model.togglePublish()
      @model.save()
        
    saveArticle: ->
      images = []
      $("output img").each (i, v) ->
        images[i] = $(this).attr("src")
      
      @model.set
        title: $('input[name=title]').val()
        author: $('input[name=author]').val()
        desc: $('textarea[name=article]').val()
        images: images.join "."
      if @model.isNew()
        app.articles.create @model,
          wait: true
          success: (res) ->
            app.navigate 'article/'+res.attributes._id, false
      else
        @model.save()
        @render()       
      @trigger('toggleEdit')
      false

    deleteArticle: ->
      @model.destroy
        success: ->
      app.navigate "/articles", false
      false
      $("#content").html ""
      