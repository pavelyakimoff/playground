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
	#App = new Backbone.Marionette.Application()
	#App.addRegions({mainRegion: "#content"})
	developerList = new Playground.Views.DeveloperListView()


	
	

	

