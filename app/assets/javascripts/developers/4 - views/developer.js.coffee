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
    @listenTo @model, 'sync', @render
    
  # event-functions
  deleteDeveloper: ->
    console.log 'deleteDeveloper'
    if @model.get('name').toLowerCase() != 'chuck' and @model.get('surname').toLowerCase() != 'norris'
      @$el.find('td').fadeOut 500, (item) => 
        @close()
        @model.destroy()
    else
      alert 'Чак уже у тебя за спиной и сейчас удалит тебя...'
      
  editDeveloper: ->
    console.log 'editDeveloper'
    console.log @
    view = new Playground.Views.DeveloperForm
      model: @model
    
    $('#forms').html(view.render().el)
    
  serializeData: ->
    @model.toJSON()
    
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
