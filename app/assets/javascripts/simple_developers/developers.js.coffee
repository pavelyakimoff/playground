//= require ./../simple/_simple

//= require_tree .

$ -> 
  $.getJSON 'developers', (obj) ->  
    Workspace.App.initialize
      model: Workspace.Models.Developer
      name: 'simple_developers'
      searchFields: ['name']
      source: obj.sections
      modelName: 'Разработчик'
      comparator: (a,b) ->

        a_title = a.get('name') ? 1 : 0
        b_title = b.get('name') ? 1 : 0

        #a = a_title.toLowerCase()
        #b = b_title.toLowerCase()

        return 1 if a > b
        return -1 if a < b

        return 0
