class Workspace.Models.Developer extends Workspace.Models.Simple
  urlRoot: '/simple_developers'
  defaults: 
    name: null
    surname: null
    phone: null
    level: 0

  validation: 
    name: 
      required: true
    surname:
      required: true
    phone:
      required: true
      pattern: 'digits'
    level:
      required: true
      pattern: 'digits'

  labels:
    name: 'Имя'
    surname: 'Фамилия'
    phone: 'Телефон'

  initialize: ->
    this.on 'change', this.highlight
    this.on 'change:name', this.setTitle

  setTitle: ->
    this.set({name: this.get('name')}, { silent: true })
    
