class Playground.Models.Developer extends Backbone.Model 
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
    
  urlRoot: '/developers'
  
  initialize: ->
    
