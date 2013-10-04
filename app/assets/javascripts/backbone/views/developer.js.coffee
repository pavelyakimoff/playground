class Playground.Views.DeveloperView extends Backbone.View 
	tagName: 'div'
	className: 'developerCart'
	template: _.template('<p><%= name %></p>')
	render: ->
		attributes = this.model.toJSON()
		this.$el.html(this.template(attributes))