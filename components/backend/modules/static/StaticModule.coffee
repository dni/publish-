define [
    'cs!Publish'
    'cs!./controller/StaticBlockController'
], ( Publish, Controller ) ->
  new Publish.Module Controller
