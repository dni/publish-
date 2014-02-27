define [
    'marionette'
    'cs!../../Command'
    'cs!./model/Magazines'
    'cs!./router/MagazineRouter'
    "text!./configuration.json"
],
( Marionette, Command, Magazines, Router, Config ) ->

  module = {
    name: "MagazineModule"
    namespace: "article"
    config: JSON.parse Config
  }

  Command.setHandler "app:ready", ()->
    App.Magazines = new Magazines
    App.Magazines.fetch
      success:->
    App.MagazineRouter = new Router
    Command.execute "app:addModule", module