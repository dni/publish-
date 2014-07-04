define [
  'cs!App'
  'cs!Publish'
  'cs!utils'
  'cs!Router'
  'marionette'
  'tpl!lib//templates/detail.html'
], (App, Publish, Utils, Router, Marionette, Template) ->

  class DetailView extends Marionette.ItemView

    constructor:(@Config)->
      @ui[key] = arg for key, arg in @Config.model

    template: Template

    templateHelpers:
      vhs: Utils.Viewhelpers
      t: @i18n

    ui:
      key: 'input[name=key]'
      data: 'textarea[name=data]'

    getAttributes:-> return attr[key] = @ui[key].val() for key, arg in @Config.model

    events:
      "click .save": "save"
      "click .cancel": "cancel"
      "click .delete": "deleteModel"

    cancel: ->
      App.contentRegion.close()
      Router.navigate @Config.name

    save: ->
      @model.set @getAttributes()
      if @model.isNew()
        App[@Config.collectionName].create @model,
          wait: true
          success: (res) ->
            route = @Config.modelName+'/'+res.attributes._id
            Utils.Log i18n.newModel, 'new',
              text: res.attributes._id
              href: route
            Router.navigate route, false
      else
        Utils.Log i18n.updateModel, 'update',
          text: @model.get '_id'
          href: @Config.modelName+'/'+@model.get '_id'
        @model.save()


    deleteModel: ->
      Utils.Log i18n.deleteModel, 'delete', text: @model.get '_id'
      @model.destroy
        success:->
      App.contentRegion.close()
