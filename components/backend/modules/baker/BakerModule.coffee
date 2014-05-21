define [
    'jquery'
    'cs!utils'
    "text!./configuration.json"
],
( $, Utils, Config ) ->
  $("body").on "downloadApp", -> window.open(window.location.origin + '/downloadApp','_blank')
  Utils.addModule Config
