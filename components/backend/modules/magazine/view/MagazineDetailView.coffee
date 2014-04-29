define [
  'jquery'
  'lodash'
  'backbone'
  'tpl!../templates/detail.html'
  'i18n!../nls/language.js'
],
( $, _, Backbone, Template, i18n) ->

  class MagazineDetailView extends Backbone.Marionette.ItemView

    template: Template
    templateHelpers: t: i18n

    ui:
      title: '[name=title]'
      author: '[name=author]'
      product_id: '[name=product_id]'
      info: '[name=info]'
      impressum: '[name=impressum]'
      editorial: '[name=editorial]'
      papersize: '[name=papersize]'
      orientation: '[name=orientation]'

    events:
      "change [name=title]": 'save'

    save: ->
      if @model.isNew() then check = 0 else check = 1
      if (App.Magazines.where title:@ui.title.val()).length > check
        @ui.title.val @ui.title.val() + '_kopie'
        return @ui.title.trigger("change")

      # set model
      @model.set
        title: @ui.title.val()
        author: @ui.author.val()
        product_id: @ui.product_id.val()
        info: @ui.info.val()
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