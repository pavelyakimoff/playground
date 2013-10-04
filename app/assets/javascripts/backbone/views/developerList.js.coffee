class Playground.Views.DeveloperListView extends Backbone.View
	el: $('#developerList')
	
	initialize: ->
		this.collection = new Playground.Collections.DevelopersCollection()
		this.render()
	
	render: ->
		that = this
		_.each(this.collection.models, this.rend(item), this)

	rend: (item) ->  
		that.renderContact(item)

	renderContact: (item) ->
		contactView = new Playground.Views.DeveloperView({model: item})
		this.$el.append(contactView.render().el)