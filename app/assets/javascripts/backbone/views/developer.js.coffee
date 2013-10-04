class Playground.Views.DeveloperView extends Backbone.View 
	tagName: 'tr'
	className: 'developerCart'
	template: "
      <td><%= name %></td>
      <td><%= surname %></td>
      <td><%= phone %></td>
      <td><a href='#' class='delete btn btn-danger'>удалить</a></td>"
  
	initialize:  ->
    this.$el.delegate('.delete','click', @deleteDeveloper)

  # event-functions
  deleteDeveloper: =>
  	this.model.delete()
  	this.$el.fadeOut(3000, (item) => this.remove() )

	render: ->
		tmpl = _.template(this.template)
		this.$el.html(tmpl(this.model.toJSON()))