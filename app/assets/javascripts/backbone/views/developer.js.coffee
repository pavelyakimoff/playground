class Playground.Views.DeveloperView extends Backbone.View 
	tagName: 'tr'
	className: 'developerCart'
	template: "
      <td><%= name %></td>
      <td><%= surname %></td>
      <td><%= phone %></td>
    "
    
	render: ->
		tmpl = _.template(this.template)
		this.$el.html(tmpl(this.model.toJSON()))