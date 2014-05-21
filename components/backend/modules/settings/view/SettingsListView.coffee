define [
  'marionette'
  'tpl!../templates/list-item.html'
], (Marionette, Template) ->

  class SettingsListItemView extends Marionette.ItemView
    template: Template

  class SettingsListView extends Marionette.CollectionView
    itemView: SettingsListItemView
