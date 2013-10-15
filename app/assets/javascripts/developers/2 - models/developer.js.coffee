class Playground.Models.Developer extends Backbone.Model
  paramRoot: 'developer'
  
  defaults: 
    name: null
    surname: null
    phone: null
    
  urlRoot: '/developers'
  
  initialize: ->
    
  delete: ->
    this.destroy()
    
  

