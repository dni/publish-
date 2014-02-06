define [
    'jquery',
    'lodash',
    'backbone',
    'cs!views/Start',
    'cs!views/ListView',
    'cs!views/DetailView',
    'cs!views/LoginView',
    'cs!views/PublicView',
    'cs!views/Navigation',
    'cs!views/MagazineDetailView',
    'cs!models/Article',
    'cs!models/Articles',
    'cs!models/Magazine',
    'cs!models/Magazines'
    'fileupload',
],
( $, _, Backbone, Start, ListView, DetailView, LoginView, PublicView, Navigation, MagazineDetailView, Article, Articles, Magazine, Magazines, fileupload ) ->

  Backbone.View.prototype.close = ->
    if @beforeClose then @beforeClose()
    @remove()
    @unbind()

  class AppRouter extends Backbone.Router
    initialize: ->
      @articles = new Articles()
      @magazines = new Magazines()
      self = @
      @articles.fetch
        success: ->
          articleList = new ListView model: self.articles
          self.showView '#sidebar', articleList, true

      @magazines.fetch
        success: ->
        error: ->
           console.log "error"

      navigation = new Navigation()
      $('.navigation').html navigation.render()
      $('#login').append new LoginView().render()


    routes:
      "": "start",
      "article/new": "addArticle",
      "article/:id": "detailsArticle",
      "articles": "articles",
      "magazine/new": "addMagazine",
      "magazine/:id": "detailsMagazine",
      "magazines": "magazines"
      "generator": "generator"

    generator: ->
       $.get "generator", (data) -> console.log data

    start: ->
      @showView '#content', new Start()

    detailsArticle: (id) ->
      article = @articles.where _id: id
      view = new DetailView model: article[0]
      @showView '#content', view
      @uploadHandler '#images'

    addArticle: ->
      view = new DetailView model: new Article()
      @showView '#content', view
      view.toggleEdit()
      @uploadHandler '#images'

    articles: ->
      articleList = new ListView model: @articles
      @showView "#sidebar", articleList, true

    detailsMagazine: (id) ->
      magazine = @magazines.where _id: id
      view = new MagazineDetailView model: magazine[0]
      @showView '#content', view
      @uploadHandler '#cover'
      @uploadHandler '#back'

    addMagazine: ->
      view = new MagazineDetailView model: new Magazine()
      @showView '#content', view
      view.toggleEdit()
      @uploadHandler '#cover'
      @uploadHandler '#back'

    magazines: ->
      view = new ListView model: @magazines
      @showView '#sidebar', view, true

    showView: (selector, view, list) ->
      $("input[type=file]").unbind()
      if list
        if @currentListView then @currentListView.close()
        @currentListView = view
        html = view.addAll()
      else
        if @currentView then @currentView.close()
        @currentView = view
        html = view.render()
      $(selector).html html

    uploadHandler: (selector)->
      $(selector + " input[type=file]").fileupload({
        dataType: 'json',
        url: 'http://localhost:8888',
        done: (e, data) ->
            $.each(data.result.files, (index, file) ->
              $('<p/>').text(file.name).appendTo(document.body)
              #$(selector + " output").html "<img width='100' class='thumb' src='"+ e.target.result+ "' title='" + escape(theFile.name) +  "'/>"
            );
        progressall: (e, data) ->
            progress = parseInt(data.loaded / data.total * 100, 10)
            $(selector + " output").text("progressALL = "progress + '%')
        progressall: (e, data) ->
            progress = parseInt(data.loaded / data.total * 100, 10)
            $(selector + " output").text("progress = "progress + '%')
        });

    # uploadHandler: (selector)->
      # $(selector + " input[type=file]").change (evt) ->
        # files = evt.target.files # FileList object
        # console.log("files: ",files)
        # i = 0
        # while f = files[i]
          # continue unless f.type.match("image.*")
          # reader = new FileReader()
          # reader.onload = ((theFile) ->
            # (e) ->
              # $(selector + " output").html "<img width='100' class='thumb' src='"+ e.target.result+ "' title='" + escape(theFile.name) +  "'/>"
          # )(f)
          # reader.readAsDataURL(f)
          # i++