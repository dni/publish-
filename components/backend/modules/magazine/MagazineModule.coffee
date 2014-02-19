define [
    'marionette'
    'cs!/modules/magazine/router/MagazineRouter'
    'cs!/modules/magazine/controller/MagazineController'
    'cs!/modules/magazine/models/Magazines'
],
( Marionette, Router, Controller, Magazines ) ->
  
  MagazineModule = App.module "MagazineModule"
  
  MagazineModule.addInitializer ->
    App.magazines = new Magazines()
    App.magazines.fetch
    new Router controller: new Controller()

  MagazineModule