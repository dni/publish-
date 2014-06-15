define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'marionette'
  'tpl!../templates/detail.html'
  'i18n!modules/magazine/nls/language.js'
],
( App, Router, Utils, Marionette, Template, i18n) ->

  class PageDetailView extends Marionette.ItemView

    template: Template
    templateHelpers:
      t: i18n
      vhs: Utils.Viewhelpers
      getArticles: -> App.Articles.toJSON()
      getLayouts: -> App.Settings.findWhere({name: "Magazines"}).getValue("layouts").split(",")

    ui:
      title: '[name=title]'
      papersize: '[name=papersize]'
      orientation: '[name=orientation]'
      publish: '.publish'

    events:
      "change [name=title]": 'save'
      "click .publish": 'publish'

    publish:->
      # before model is toggled
      if @model.get("published") then @ui.publish.addClass("btn-success").text('Publish') else @ui.publish.removeClass("btn-success").text('Unpublish')
      @model.togglePublish()
      @save()

    save: ->
      if @model.isNew() then check = 0 else check = 1
      if (App.Pages.where title:@ui.title.val()).length > check
        @ui.title.val @ui.title.val() + '_copy'
        return @ui.title.trigger("change")

      # set model
      @model.set
        title: @ui.title.val()

      if @model.isNew()
        App.Pages.create @model,
          wait: true
          success: (res) ->
            route = 'page/'+res.attributes._id
            Utils.Log i18n.newPage, 'new',
              text: res.attributes.title
              href: route
            Router.navigate route, trigger:false
      else
        Utils.Log i18n.updatePage, 'update',
          text: @model.get 'title'
          href: 'page/'+@model.get '_id'
        @model.save()
