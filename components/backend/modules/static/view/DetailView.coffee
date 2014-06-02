define [
  'cs!App'
  'cs!Router'
  'cs!utils'
  'i18n!modules/static/nls/language.js'
  'marionette'
  'tpl!../templates/detail.html'
], (App, Router, Utils, i18n, Marionette, Template) ->

  class StaticDetailView extends Marionette.ItemView

    template: Template
    templateHelpers:
      vhs: Utils.Viewhelpers
      t: i18n

    ui:
      key: 'input[name=key]'
      data: 'textarea[name=data]'

    events:
      "click .save": "save"
      "click .cancel": "cancel"
      "click .delete": "deleteStatic"

    cancel: ->
      App.contentRegion.close()
      Router.navigate 'staticBlocks'

    save: ->
      @model.set
        key: @ui.key.val()
        data: @ui.data.val()
      if @model.isNew()
        App.StaticBlocks.create @model,
          wait: true
          success: (res) ->
            route = 'staticBlock/'+res.attributes._id
            Utils.Log i18n.newStatic, 'new',
              text: res.attributes.key
              href: route
            Router.navigate route, false
      else
        Utils.Log i18n.updateStatic, 'update',
          text: @model.get 'key'
          href: 'staticBlock/'+@model.get '_id'
        @model.save()


    deleteStatic: ->
      Utils.Log i18n.deletStatic, 'delete', text: @model.get 'key'
      @model.destroy
        success:->
      App.contentRegion.close()
