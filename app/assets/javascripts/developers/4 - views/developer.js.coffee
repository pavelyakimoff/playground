class Playground.Views.Developer extends Backbone.Marionette.ItemView
  tagName: 'tr'
  className: 'developerInfo'
  template: "developers/1_templates/developer"
  
  events: 
    'click .delete': 'sure'
    'click .edit':   'editDeveloper'
  
  initialize: ->
    this.listenTo(this.model, 'change', this.render)
    
  # event-functions
  deleteDeveloper: ->
    console.log 'deleteDeveloper'
    this.$el.find('td').fadeOut 500, (item) => 
      this.remove()
      this.model.delete()
      
  editDeveloper: ->
    console.log 'editDeveloper'
    @model.view = new Playground.Views.DeveloperForm
      model: this.model
    
    $('#forms').html(@model.view.render().el)
    
  serializeData: ->
    this.model.toJSON()
    
  sure: (ev) ->
    ev.preventDefault()
    console.log 'sure'
    @deleteDeveloper() if confirm('Точно удалить?')
      
