#= require_self

window.Playground =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  initialize: -> 
    #alert 'Hello from Backbone!'

$($.proxy(Playground.initialize, Playground));
