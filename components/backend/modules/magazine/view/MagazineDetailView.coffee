define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
],
( $, _, Backbone, Template) ->

  class MagazineDetailView extends Backbone.Marionette.ItemView

    template: Template

    events:
      "blur input": "save"
      "change select": "save"

    ui:
      title: '[name=title]'
      author: '[name=author]'
      impressum: '[name=impressum]'
      editorial: '[name=editorial]'
      papersize: '[name=papersize]'
      orientation: '[name=orientation]'


    save: ->
      @model.set
        title: @ui.title.val()
        author: @ui.author.val()
        impressum: @ui.impressum.val()
        editorial: @ui.editorial.val()
        papersize: @ui.papersize.val()
        orientation: @ui.orientation.val()

      if @model.isNew()
        App.Magazines.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'magazine/'+res.attributes._id, false
      else
        @model.save
          success:->

