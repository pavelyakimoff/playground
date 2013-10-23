//= require_tree .

$ ->

  Backbone.Marionette.Renderer.render = (template, data) ->
    throw "Template ['" + template + "'] not found!"  unless JST[template]
    JST[template] data

  Playground.App = new Backbone.Marionette.Application()

  Playground.App.addRegions
    mainRegion: '#developers'

  Playground.App.addInitializer ->
    Playground.App.collection = new Playground.Collections.Developers()
    Playground.App.collection.fetch().done ->
      window.developersListHtml = new Playground.Views.Developers
        collection: Playground.App.collection
      
      Playground.App.mainRegion.show(developersListHtml)

  Playground.App.start()
