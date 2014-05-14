define [
  'marionette'
  'cs!utils'
],
( Marionette, utils) ->
  class Router extends Marionette.AppRouter
    onRoute: (name, path, args)->
      utils.Log name + path + args
