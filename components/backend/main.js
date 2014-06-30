require(["backbone", "cs!utils"],function(Backbone, Utils){
    var start = function(){ Backbone.history.start(); }
    Utils.Vent.on("app:ready", start)
    setTimeout(start, 1000);
});
