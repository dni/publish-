define ['jquery', 'lodash', 'backbone', 'text!templates/magazinedetail.html', 'cs!models/Pages', 'cs!models/Page', 'cs!views/PageListView'], ( $, _, Backbone, Template, Pages, Page, PageListView) -> 
	
  class MagazineDetailView extends Backbone.View
    # Not required since 'div' is the default if no el or tagName specified
    initialize: ->
      @template = _.template Template   
      @pages = new Pages()
      if @model.get("pages").length > 0
        pages = []
        pages[i] = new Page pageJSON for pageJSON, i in @model.get "pages"
        @pages.reset pages
        
      @model.bind "change", @render, @
      @pageList = new PageListView model: @pages

    
    render: (eventName) ->
      @$el.html @template
        model:@model.toJSON()
        articles: app.articles.toJSON()
        
      @$el.find('#pageList').html @pageList.addAll()   
      @el
        
    events: 
      "click #edit": "toggleEdit"
      "click .save": "saveMagazine"
      "click .delete": "deleteMagazine"
      'click #publish': "publishMagazine"
      "click #addPage": "addPage"
      "click #hpub": "generateHpub"
      "click #print": "generatePrint"
      "click #download": "downloadPrint"
      
    downloadPrint: ->
       form = $ '<form>', 
          action: '/downloadPrint'
          method: 'POST'
          
       form.append $ '<input>',
          name: 'title'
          value: @model.get "title"
       
          
       form.submit();
      
    generateHpub: ->
      $.post "/generate",
        id: @model.get "_id" 
        title: @model.get "title"
      , (data) -> console.log data
      
    generatePrint: ->
      $.post "/generatePrint", 
        id: @model.get "_id" 
        title: @model.get "title"
      , (data) -> console.log data

    addPage: ->
      @pages.add new Page pagecount: @pages.models.length

    toggleEdit: ->
      @$el.find('.edit').toggle();
      @$el.find('.preview').toggle();
      @$el.find('.saved').toggle();      
        
    publishMagazine: ->
      @model.togglePublish()
      @model.save()
        
    saveMagazine: ->
      @model.set
        title: $('input[name=title]').val()
        impressum: $('textarea[name=impressum]').val()
        editorial: $('textarea[name=editorial]').val()
        cover: $("#cover output img").attr("src")
        back: $("#back output img").attr("src")
        pages: @pages
      if @model.isNew()
        self = @;
        app.magazines.create @model,
          wait: true
          success: (res) ->
            app.navigate 'magazine/'+res.attributes._id, false
      else
        @model.save()
        @render()       
      @trigger('toggleEdit')
      false

    deleteMagazine: ->
      @model.destroy
        success: ->
      app.navigate "/magazines", false
      $("#content").html ""
      false
      