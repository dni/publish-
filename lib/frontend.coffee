require ['jquery','lodash','backbone','cs!FrontendRouter'],( $, _, Backbone, FrontendRouter ) ->
  Backbone.history.start()
  window.app = new FrontendRouter()
