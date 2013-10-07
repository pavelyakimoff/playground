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
    App = new Backbone.Marionette.Application()

    App.addRegions
        mainRegion: '#developers'

    App.addInitializer ->
        ###developers = new Playground.Collections.DeveloperCollection([
            { name: 'Pavel', surname: 'Yakimoff', phone: '45454' },
            { name: 'Pavel', surname: 'Yakimoff', phone: '45454' },
            { name: 'Pavel', surname: 'Yakimoff', phone: '45454' }
        ])###
        developers = new Playground.Collections.DeveloperCollection()
        developers.fetch().done ->
            developersView = new Playground.Views.DevelopersView {collection: developers}
            App.mainRegion.show(developersView)

    App.start()