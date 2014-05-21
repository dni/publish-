define [
  'cs!App'
  'cs!Router'
  'marionette'
  'tpl!../templates/detail.html'
], (App, Router, Marionette, Template) ->

  class StaticDetailView extends Marionette.ItemView

    template: Template

    ui:
      edit: ".edit"
      deleteable: ".deleteable"
      key: 'input[name=key]'
      data: 'textarea[name=data]'

    events:
      "click .revert": "revertStatic"
      "click .save": "saveStatic"
      "click .cancel": "cancel"

    cancel: ->
      App.contentRegion.close()
      Router.navigate 'articles'

    addFiles:->
      Router.navigate "filebrowser", true

    revertStatic: ->
      @model.destroy success: ->
      window.document.location.reload()

    saveStatic: ->
      @model.set
        key: @ui.key.val()
        data: @ui.data.val()
      if @model.isNew()
        App.StaticBlocks.create @model,
          wait: true
          success: (res) ->
            Router.navigate 'static/'+res.attributes._id, false
      else
        @model.save()


    deleteStatic: ->
      @model.destroy
        success:->
      App.contentRegion.close()
