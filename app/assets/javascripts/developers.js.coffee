# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	Developers = Backbone.Collection.extend url: 'http://localhost:3000/developers/json'
	developers = new Posts()
	developers.fetch()
	console.log developers.length