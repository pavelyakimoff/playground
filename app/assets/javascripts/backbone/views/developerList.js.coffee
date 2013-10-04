class Playground.Views.DeveloperListView extends Backbone.View
	el: $('#developerList')
	
	initialize: ->
		this.collection = new Playground.Collections.DevelopersCollection()
		this.collection.fetch().done =>
			console.log 'Приложение запущено! Получена коллекция - кол-во объектов в коллекции ' + this.collection.length
			this.render()
			
	render: ->		
		this.collection.models.forEach (developer) =>
			this.renderDeveloper(developer)

	renderDeveloper: (developer) ->
		console.log 'Рендеринг вьюхи разработчика ' + developer.get('name')
		developerView = new Playground.Views.DeveloperView({model: developer})
		$('#developerList').append(developerView.render())
