define ['jquery', 'lodash', 'backbone', 'tpl!../templates/listItem.html', 'tpl!../templates/list.html', 'tpl!../templates/filter.html'], 
($, _, Backbone, Template, ListTemplate, FilterTemplate) ->

  class SettingsListItemView extends Backbone.Marionette.ItemView 
    template: Template
   
  class SettingsListView extends Backbone.Marionette.CollectionView
    itemView: SettingsListItemView
    