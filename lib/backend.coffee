require ['jquery','lodash','backbone','cs!AppRouter'],( $, _, Backbone, AppRouter ) ->
  Backbone.history.start()
  window.app = new AppRouter()
