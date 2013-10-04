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
	developers = new Playground.Collections.DevelopersCollection()
	developers.fetch().done ->
		developers.forEach (developer) ->
			console.log developer.get('name')

	
	

	

