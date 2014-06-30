define [
  'cs!App'
  'cs!Publish'
  'cs!../MyModule'
  'cs!../view/MyListView'
  'cs!../view/MyDetailView'
  'cs!../model/MyModel'
], ( App, Publish, MyModule, i18n, MyModuleListView, MyModuleDetailView, MyModuleModel) ->

  class MyController extends Publish.Controller
    Config: MyModule.Config
    i18n: MyModule.i18n
    Model: MyModuleModel
    DetailView: MyModuleDetailView
    ListView: MyModuleListView