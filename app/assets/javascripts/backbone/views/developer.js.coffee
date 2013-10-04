class Playground.Views.DeveloperView extends Backbone.View 
	tagName: 'div'
	className: 'developerCart'
	template: '<p><%= name %></p>'
	render: ->
		tmpl = _.template(this.template)
		this.$el.html(tmpl(this.model.toJSON()))