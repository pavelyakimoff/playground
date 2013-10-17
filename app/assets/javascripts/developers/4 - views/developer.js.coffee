class Playground.Views.Developer extends Backbone.Marionette.ItemView
  tagName: 'tr'
  className: 'developerInfo'
  template: "developers/1_templates/developer"
  
  events: 
    'click .delete': 'sure'
    'click .edit':   'editDeveloper'
    'click .level .down': 'levelDown'
    'click .level .up': 'levelUp'
  
  initialize: ->
    this.listenTo @model, 'sync', this.render
    
  # event-functions
  deleteDeveloper: ->
    console.log 'deleteDeveloper'
    this.$el.find('td').fadeOut 500, (item) => 
      this.close()
      this.model.destroy()
      
  editDeveloper: ->
    console.log 'editDeveloper'
    console.log @
    @model.view = new Playground.Views.DeveloperForm
      model: this.model
    
    $('#forms').html(@model.view.render().el)
    
  serializeData: ->
    this.model.toJSON()
    
  sure: (ev) ->
    ev.preventDefault()
    console.log 'sure'
    @deleteDeveloper() if confirm('Точно удалить?')
    
  levelDown: ->
    level = @model.get('level')
    console.log 'levelDown'
    unless level == 0
      console.log 'level was ' + level + ' now is ' + --level
      @model.save({level: level}, {wait: true}).done =>
        @model.collection.sort()
    
  levelUp: ->
    level = @model.get('level')
    console.log 'levelUp'
    console.log 'level was ' + level + ' now is ' + ++level
    @model.save({level: level}, {wait: true}).done =>
      @model.collection.sort()
