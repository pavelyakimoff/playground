//= require_tree .

$ ->

  Backbone.Marionette.Renderer.render = (template, data) ->
    throw "Template ['" + template + "'] not found!"  unless JST[template]
    JST[template] data

  App = new Backbone.Marionette.Application()

  App.addRegions
    mainRegion: '#developers'

  App.addInitializer ->
    developers = new Playground.Collections.DevelopersCollection()
    $.getJSON '/developers/json', (json) ->
      $.each json, (key, model) ->
        console.log model
      
        developers.add model
    # developers.fetch().done ->
    #   developersView = new Playground.Views.DevelopersView
    #     collection: developers
      
    #   App.mainRegion.show(developersView)

  App.start()
