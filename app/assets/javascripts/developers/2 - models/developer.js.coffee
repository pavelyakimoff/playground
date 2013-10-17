class Playground.Models.Developer extends Backbone.Model
  paramRoot: 'developer'
  
  defaults: 
    name: null
    surname: null
    phone: null
    
  validation: 
    name: 
      required: true
    surname:
      required: true
    phone:
      required: true
      pattern: 'digits'
      
  labels:
    name: 'Имя'
    surname: 'Фамилия'
    phone: 'Телефон'
    
  urlRoot: '/developers'
  
  initialize: ->
    
