#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Playground =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  initialize: -> alert 'Hello from Backbone!'

$ ->    

    Backbone.Marionette.Renderer.render = (template, data) ->
      throw "Template ['" + template + "'] not found!"  unless JST[template]
      console.log '123'
      JST[template] data

    App = new Backbone.Marionette.Application()

    App.addRegions
        mainRegion: '#developers'

    App.addInitializer ->
        developers = new Playground.Collections.DeveloperCollection()
        developers.fetch().done ->
            developersView = new Playground.Views.DevelopersView {collection: developers}
            App.mainRegion.show(developersView)

    App.start()