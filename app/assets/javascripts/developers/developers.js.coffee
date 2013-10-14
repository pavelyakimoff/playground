//= require_tree .

$ ->

  Backbone.Marionette.Renderer.render = (template, data) ->
    throw "Template ['" + template + "'] not found!"  unless JST[template]
    JST[template] data

  App = new Backbone.Marionette.Application()

  App.addRegions
    mainRegion: '#developers'

  App.addInitializer ->
    developers = new Playground.Collections.Developers()
    developers.fetch().done ->
      developersView = new Playground.Views.Developers
        collection: developers
      
      App.mainRegion.show(developersView)

  App.start()
