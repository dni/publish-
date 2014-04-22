define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
],
( $, _, Backbone, Template) ->

  class MagazineDetailView extends Backbone.Marionette.ItemView

    template: Template

    ui:
      title: '[name=title]'
      author: '[name=author]'
      impressum: '[name=impressum]'
      editorial: '[name=editorial]'
      papersize: '[name=papersize]'
      orientation: '[name=orientation]'

    events:
      "change [name=title]": 'save'

    save: ->

      # check duplicate
      if @model.isNew() then check = 0 else check = 1
      if (App.Magazines.where title:@ui.title.val()).length > check then @ui.title.val @ui.title.val() + '_kopie'

      # set model
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
            c.l "success save magazine", res
            App.Router.navigate 'magazine/'+res.attributes._id, false
      else
        @model.save
          success:->